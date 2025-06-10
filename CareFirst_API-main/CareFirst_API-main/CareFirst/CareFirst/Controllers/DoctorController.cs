using CareFirst.Context;
using CareFirst.Dtos.DoctorDto;
using CareFirst.IRepository;
using CareFirst.Mapper;
using CareFirst.Model;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Drawing;

namespace CareFirst.Controllers
{
    [Route("Doctor")]
    [ApiController]
    
    public class DoctorController : ControllerBase
    {
		private readonly IDoctorRepository _doctor;
		private readonly ApplicationDbContext _context;

        public DoctorController(IDoctorRepository doctor, ApplicationDbContext context)
        {
			_doctor = doctor;
			_context = context;
        }
		//[AllowAnonymous]
		//[HttpPost("Doctor", Name = "DoctorAccount")]

		//public async Task<ActionResult<Doctor>> SetDoctor(DoctorDto doctorDto)
  //      {
  //          var Doctor = new Doctor()
  //          {
  //              Name = doctorDto.Name,
  //              Info = doctorDto.Info,
  //              Rating = doctorDto.Rating.HasValue ? (int)doctorDto.Rating.Value : 0,
  //              Location = doctorDto.Location,
  //              ProfilePicture = doctorDto.ProfilePicture,
  //              DepartmentId = doctorDto.DepartmentId,

  //          };


  //           await _context.AddAsync(Doctor);
  //          await _context.SaveChangesAsync();

  //          return Ok(Doctor);
  //      }


        [HttpGet("Get", Name = "GetAllDoctors")]
        public async Task<ActionResult> GetAllDoctors([FromQuery] string Department = "")
        {
            int DepartmentID = 0;
            if (Department != "")
            {
                if (Enum.TryParse(Department, out DoctorDepartmentTypes name))
                {
                    DepartmentID = (int)name;
                }
                else
                {
                    return NotFound("Department Name Not Found (404)");
                }
            }
            var listDoctors = await _doctor.GetAllDoctorsAsync(DepartmentID);
            if (listDoctors == null)
                return NotFound("There Are No Doctors (404)");

            var listDoctorDto = listDoctors.Select(Doctor => Doctor.ToDoctorDto());

            return Ok(listDoctorDto);
        }

        [HttpGet("ID/{Id}", Name = "GetDoctorByID")]
        public async Task<ActionResult> GetDoctorByID(int Id)
        {
            if (Id <= 0)
            {
                return BadRequest("You must add an available ID.");
            }
            var doctor = await _doctor.GetDoctorByIdAsync(Id);
            if (doctor == null)
                return NotFound("This doctor is not available.");
            return Ok(doctor.ToDoctorByIdDto());
        }
        [Authorize(Roles ="Admin")]
        [HttpPut("change/{appintmentId}", Name = "ChangeAppointment")]
        public async Task<ActionResult> ChangeAppointment(int appintmentId)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest("The data is wrong.");
            }
            if (appintmentId == 0)
                return BadRequest("The data is wrong.");

            bool IsChange = await _doctor.ChangeStateAsync(appintmentId);
            if (!IsChange)
                return NotFound("You can't Change State");
            return Ok("Data Change Successfully User Now Can User Add Review");
        }
    }
}
