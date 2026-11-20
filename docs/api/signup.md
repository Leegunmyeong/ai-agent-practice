# 회원가입

domain: member

url: /members

method: POST

# 01. 설명

이메일, 비밀번호, 닉네임으로 새 회원을 가입시킬 때 사용한다.

- 이메일, 비밀번호, 닉네임은 모두 필수이다.
- 이메일은 중복될 수 없다.
- 결정 필요: 비밀번호 규칙, 닉네임 길이/허용 문자/중복 여부, 이메일 인증 여부, 가입 직후 토큰 발급 여부.

# 02. 요청(Request)

## a. Parameter & Querystring

```txt
/members
```

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| 없음 | | | |

## b. request headers

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| 없음 | | | |

## c. request body

```json
{
  "email": "user@example.com",
  "password": "password1234!",
  "nickname": "gygim"
}
```

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| email | String | Y | 가입할 이메일. 중복 불가. 이메일 형식 검증 여부 결정 필요 |
| password | String | Y | 비밀번호. 길이/조합 등 규칙 결정 필요 |
| nickname | String | Y | 닉네임. 길이/허용 문자/중복 여부 결정 필요 |

# 03. 응답(Response)

## a. response header

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| 없음 | | | |

## b. response body

**성공 응답:** `201 Created`

```json
{
  "id": 1,
  "email": "user@example.com",
  "nickname": "gygim",
  "createdAt": "2026-11-20T10:00:00"
}
```

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| id | Long | Y | 가입된 회원 식별자 |
| email | String | Y | 가입한 이메일 |
| nickname | String | Y | 가입한 닉네임 |
| createdAt | String | Y | 가입 일시 |

비밀번호는 응답에 포함하지 않는다. 토큰 포함 여부는 결정 필요.

**에러 응답:** `409 Conflict` — 이미 가입된 이메일일 때

```json
{
  "message": "email already exists",
  "status": 409
}
```

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| message | String | Y | 에러 메시지 |
| status | Integer | Y | HTTP 상태 코드 |

**에러 응답:** `400 Bad Request` — 필수 값이 없거나 형식이 올바르지 않을 때 (구체적 검증 규칙은 결정 필요)

```json
{
  "message": "invalid request",
  "status": 400
}
```

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| message | String | Y | 에러 메시지 |
| status | Integer | Y | HTTP 상태 코드 |
