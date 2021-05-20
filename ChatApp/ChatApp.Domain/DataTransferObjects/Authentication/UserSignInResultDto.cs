namespace ChatApp.Domain.DataTransferObjects
{
    public record UserSignInResultDto
    {
        public bool IsSuccess { get; set; }
        public string Message { get; set; }
        public string Token { get; set; }
        
    }
}