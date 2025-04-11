// TokenController.cs
[ApiController]
[Route("api/[controller]")]
public class TokenController : ControllerBase
{
private readonly ITokenService \_tokenService;

    public TokenController(ITokenService tokenService)
    {
        _tokenService = tokenService;
    }

    [HttpGet("{tokenId}")]
    public async Task<ActionResult<TokenDetails>> GetTokenDetails(string tokenId)
    {
        var result = await _tokenService.GetTokenDetailsAsync(tokenId);
        if (result == null) return NotFound();
        return Ok(result);
    }

}

// TokenDetails.cs
public class TokenDetails
{
public string Token { get; set; }
public string Id { get; set; }
public string Date { get; set; }
public string Value { get; set; }
public string Handling { get; set; }
public bool IsValid { get; set; }
public string Pin { get; set; }
}

// TokenService.cs
public class TokenService : ITokenService
{
private readonly SqlConnection \_connection;

    public async Task<TokenDetails> GetTokenDetailsAsync(string tokenId)
    {
        using var command = new SqlCommand(
            @"SELECT Token, Id, ExpiryDate, Value, Handling,
              IsValid, Pin FROM TokenDetails WHERE Token = @TokenId",
            _connection
        );
        command.Parameters.AddWithValue("@TokenId", tokenId);

        var result = await command.ExecuteReaderAsync();
        if (await result.ReadAsync())
        {
            return new TokenDetails
            {
                Token = result.GetString(0),
                Id = result.GetString(1),
                Date = result.GetDateTime(2).ToString("dd MMM yyyy"),
                Value = result.GetString(3),
                Handling = result.GetString(4),
                IsValid = result.GetBoolean(5),
                Pin = result.GetString(6)
            };
        }
        return null;
    }

}

// token_api_service.dart
class TokenApiService {
final String baseUrl = 'https://your-api-url/api';
final dio = Dio();

Future<TokenDetails> getTokenDetails(String tokenId) async {
try {
final response = await dio.get('$baseUrl/token/$tokenId');
return TokenDetails.fromJson(response.data);
} on DioError catch (e) {
throw ApiException(message: 'Failed to fetch token details: ${e.message}');
}
}
}

// token_details_model.dart
class TokenDetails {
final String token;
final String id;
final String date;
final String value;
final String handling;
final bool isValid;
final String pin;

TokenDetails({
required this.token,
required this.id,
required this.date,
required this.value,
required this.handling,
required this.isValid,
required this.pin,
});

factory TokenDetails.fromJson(Map<String, dynamic> json) {
return TokenDetails(
token: json['token'] ?? '',
id: json['id'] ?? '',
date: json['date'] ?? '',
value: json['value'] ?? '',
handling: json['handling'] ?? '',
isValid: json['isValid'] ?? false,
pin: json['pin'] ?? '',
);
}
}

// Implementation in token_scan.dart
class \_TokenScanPageState extends State<TokenScanPage> {
final TokenApiService \_apiService = TokenApiService();

Future<void> \_validateToken(String scannedToken) async {
try {
final tokenDetails = await \_apiService.getTokenDetails(scannedToken);
setState(() {
\_scannedValue = tokenDetails.isValid
? '✅ Token Details: ${tokenDetails.token}'
: '❌ Error: Invalid Token';
\_isTokenValid = tokenDetails.isValid;
});
} catch (e) {
setState(() {
\_scannedValue = '❌ Error: Failed to validate token';
\_isTokenValid = false;
});
}
}
}

CREATE TABLE TokenDetails (
Token VARCHAR(50) PRIMARY KEY,
Id VARCHAR(50) NOT NULL,
ExpiryDate DATETIME NOT NULL,
Value VARCHAR(20) NOT NULL,
Handling VARCHAR(20) NOT NULL,
IsValid BIT NOT NULL,
Pin VARCHAR(10) NOT NULL,
CreatedDate DATETIME DEFAULT GETDATE(),
LastUpdated DATETIME DEFAULT GETDATE()
);

-- Index for faster lookups
CREATE INDEX IX_TokenDetails_Token ON TokenDetails(Token);

class ApiException implements Exception {
final String message;
ApiException({required this.message});
}

// Usage in API service
Future<TokenDetails> getTokenDetails(String tokenId) async {
try {
final response = await dio.get('$baseUrl/token/$tokenId');
if (response.statusCode == 200) {
return TokenDetails.fromJson(response.data);
} else {
throw ApiException(message: 'Failed to fetch token details');
}
} catch (e) {
throw ApiException(message: 'Network error: ${e.toString()}');
}
}
