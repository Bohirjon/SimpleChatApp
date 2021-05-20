using System;

namespace ChatApp.Domain.DataTransferObjects
{
    public record UserInformationDto
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        
    }
}