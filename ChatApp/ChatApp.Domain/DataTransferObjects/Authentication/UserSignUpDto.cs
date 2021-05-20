namespace ChatApp.Domain.DataTransferObjects
{
    public record UserSignUpDto
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
    }
}