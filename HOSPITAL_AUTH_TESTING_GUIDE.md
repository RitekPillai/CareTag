# Hospital Authentication Testing Guide

## Token Configuration
- **JWT Token Expiry**: 10 minutes
- **Refresh Token Expiry**: 30 days
- **Storage**: Refresh tokens stored in MongoDB

## API Endpoints

### 1. Hospital Registration
```
POST /hospital/signup
Content-Type: application/json

{
  "name": "Test Hospital",
  "email": "hospital@test.com",
  "password": "SecurePass123",
  "phone": "9876543210",
  "website": "https://hospital.com",
  "address": "123 Medical Street",
  "city": "New Delhi",
  "state": "Delhi",
  "pincode": "110001",
  "latitude": 28.6139,
  "longitude": 77.2090,
  "logoUrl": "base64_encoded_image",
  "numberOfBeds": 100,
  "departments": ["Cardiology", "Neurology"],
  "registrationNumber": "REG123456",
  "registrationCertificateUrl": "base64_encoded_cert",
  "accreditationNumber": "ACC123",
  "accreditationType": "NABH",
  "clinicalEstablishmentLicenseUrl": "base64_encoded_license",
  "gstNumber": "18AABCU9603R1Z5",
  "branches": []
}

Response:
{
  "message": "Hospital registered successfully. Pending verification."
}
```

### 2. Hospital Login (Gets JWT & Refresh Token)
```
POST /hospital/login
Content-Type: application/json

{
  "email": "hospital@test.com",
  "password": "SecurePass123"
}

Response:
{
  "jwtToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "550e8400-e29b-41d4-a716-446655440000",
  "hospitalId": 1234567890,
  "email": "hospital@test.com",
  "name": "Test Hospital"
}
```

### 3. Refresh JWT Token (Core Feature - No Re-login Needed)
```
POST /hospital/refresh
Content-Type: text/plain

550e8400-e29b-41d4-a716-446655440000

Response:
{
  "token": "550e8400-e29b-41d4-a716-446655440000",
  "jwtToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

## Testing Workflow

### Scenario 1: Login & Access Protected Resource
```bash
# 1. Login
curl -X POST http://localhost:8080/hospital/login \
  -H "Content-Type: application/json" \
  -d '{"email":"hospital@test.com","password":"SecurePass123"}'

# Response contains jwtToken and refreshToken
# Save both tokens

# 2. Access protected hospital resource
curl -X GET http://localhost:8080/hospital \
  -H "Authorization: Bearer <jwtToken>"

# Response: "Hospital controller working"
```

### Scenario 2: Keep JWT Fresh (Main Feature)
```bash
# 1. After 10 minutes, JWT expires
# 2. Instead of re-login, use refresh token
curl -X POST http://localhost:8080/hospital/refresh \
  -H "Content-Type: text/plain" \
  -d '<refreshToken>'

# Response contains new jwtToken
# Use new JWT for subsequent requests - NO RE-LOGIN NEEDED!
```

### Scenario 3: Refresh Token Expires (30 days)
```bash
# After 30 days, refresh token expires
curl -X POST http://localhost:8080/hospital/refresh \
  -H "Content-Type: text/plain" \
  -d '<expiredRefreshToken>'

# Response: 401 Unauthorized - "Refresh Token Has been Expireyd"
# User must login again (normal behavior after 30 days)
```

## Frontend Implementation Pattern

### React/Flutter Implementation
```javascript
// 1. Login
const login = async (email, password) => {
  const response = await fetch('/hospital/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });
  const data = await response.json();
  localStorage.setItem('jwtToken', data.jwtToken);
  localStorage.setItem('refreshToken', data.refreshToken);
  return data;
};

// 2. Setup axios interceptor for auto-refresh
axios.interceptors.response.use(
  response => response,
  async error => {
    if (error.response?.status === 401) {
      const refreshToken = localStorage.getItem('refreshToken');
      const response = await fetch('/hospital/refresh', {
        method: 'POST',
        headers: { 'Content-Type': 'text/plain' },
        body: refreshToken
      });
      const data = await response.json();
      localStorage.setItem('jwtToken', data.jwtToken);

      // Retry original request with new JWT
      return axios(error.config);
    }
    return Promise.reject(error);
  }
);

// 3. All requests automatically use JWT
const makeRequest = async (url) => {
  return fetch(url, {
    headers: {
      'Authorization': `Bearer ${localStorage.getItem('jwtToken')}`
    }
  });
};
```

## Verification Checklist

- [ ] Hospital signup creates user in User collection
- [ ] Hospital signup creates hospital in Hospital collection
- [ ] Hospital login returns both jwtToken and refreshToken
- [ ] JWT token is valid for 10 minutes
- [ ] Refresh token is valid for 30 days
- [ ] Using refresh token generates new JWT without re-login
- [ ] JWT contains correct claims (userId, email, roles)
- [ ] Protected endpoints return 401 without valid JWT
- [ ] Protected endpoints return 403 without HOSPITAL role
- [ ] Refresh endpoint returns 401 with expired refresh token
- [ ] Same flow works for Doctor (/doctor/refresh)
- [ ] Same flow works for Diagnostic (/diagnostic/refresh)

## Similar Implementation for Doctor & Diagnostic

All user types now have:
- **POST /doctor/refresh** - Refresh doctor JWT
- **POST /diagnostic/refresh** - Refresh diagnostic JWT

Same token configuration and workflow apply.

## Database Collections

### User Collection
```json
{
  "_id": 1234567890,
  "email": "hospital@test.com",
  "password": "bcrypted_password",
  "authProvider": "EMAIL",
  "role": ["HOSPITAL"],
  "verified": true
}
```

### RefreshToken Collection
```json
{
  "_id": 9876543210,
  "token": "550e8400-e29b-41d4-a716-446655440000",
  "email": "hospital@test.com",
  "expiryTime": "2026-04-30T12:00:00Z"
}
```

### Hospital Collection
```json
{
  "_id": 1234567890,
  "name": "Test Hospital",
  "email": "hospital@test.com",
  "verificationStatus": "pending",
  "createdAt": "2026-03-31T12:00:00Z"
}
```

## Troubleshooting

### Issue: "Refresh Token Has been Expireyd"
- Token is older than 30 days
- **Solution**: User must login again

### Issue: 401 Unauthorized on protected endpoint
- JWT is missing or invalid
- **Solution**: Use `/refresh` endpoint to get new JWT

### Issue: 403 Forbidden on protected endpoint
- JWT is valid but user role doesn't match
- **Solution**: Ensure user has correct role (use `/exchange` endpoint)

### Issue: Cannot refresh with old refresh token
- Refresh token was deleted from database
- Database connection issue
- **Solution**: Check MongoDB connection and token validity
