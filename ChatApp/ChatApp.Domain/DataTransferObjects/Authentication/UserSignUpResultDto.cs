namespace ChatApp.Domain.DataTransferObjects
{
    public record UserSignUpResult
    {
        public bool IsSuccess { get; set; }
        public string Token { get; set; }
        public string Message { get; set; }
    }
}