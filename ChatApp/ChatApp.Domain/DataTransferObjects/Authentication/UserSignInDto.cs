namespace ChatApp.Domain.DataTransferObjects
{
    public record UserSignInDto
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}