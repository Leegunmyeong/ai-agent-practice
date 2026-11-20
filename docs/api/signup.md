# 회원가입

domain: member

url: /members

method: POST

# 01. 설명

이메일, 비밀번호, 닉네임으로 새 회원을 가입시킬 때 사용한다.

- 이메일, 비밀번호, 닉네임은 모두 필수이며 null·빈 값·공백만 있는 값은 허용하지 않는다.
- 이메일은 최대 100자의 이메일 형식이어야 하고 중복될 수 없다.
- 비밀번호는 4~20자이며 영문, 숫자, 특수문자를 각각 1개 이상 포함해야 하고 공백을 포함할 수 없다.
- 닉네임은 4~20자이며 영문(대·소문자), 숫자, 한글만 허용하고 중복될 수 없다.
- 여러 값이 동시에 잘못되면 아래 에러 응답 순서대로 검사해 첫 번째 오류 하나만 반환한다.

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
| email | String | Y | 가입할 이메일. null·빈 값·공백 불가, 이메일 형식, 최대 100자, 중복 불가 |
| password | String | Y | 비밀번호. 4~20자, 영문·숫자·특수문자 각 1개 이상. null·빈 값·공백 불가(공백 문자 포함 불가), 특수문자 허용 |
| nickname | String | Y | 닉네임. 4~20자, 영문(대·소문자)·숫자·한글만 허용(특수문자·공백 불가), 중복 불가 |

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

비밀번호는 응답에 포함하지 않는다. 토큰은 회원가입에서 발급하지 않고 로그인 API에서 다룬다.

**에러 응답**

모든 에러 응답 body는 아래 두 필드만 가진다.

| 이름 | 데이터타입 | 필수 | 설명 |
|---|---|---|---|
| message | String | Y | 클라이언트 화면에 그대로 보여 줄 에러 메시지 |
| status | Integer | Y | HTTP 상태 코드 |

| 상태 | 발생 조건 | message |
|---|---|---|
| 400 | email이 null·빈 값·공백만 있을 때 | 이메일을 입력해 주세요. |
| 400 | email이 이메일 형식이 아닐 때 | 올바른 이메일 형식으로 입력해 주세요. |
| 400 | email이 100자를 넘을 때 | 이메일은 100자 이하로 입력해 주세요. |
| 400 | password가 null·빈 값·공백만 있을 때 | 비밀번호를 입력해 주세요. |
| 400 | password에 공백 문자가 있을 때 | 비밀번호에는 공백을 사용할 수 없습니다. |
| 400 | password가 4자 미만이거나 20자를 넘을 때 | 비밀번호는 4자 이상 20자 이하로 입력해 주세요. |
| 400 | password에 영문·숫자·특수문자 중 하나라도 없을 때 | 비밀번호는 영문, 숫자, 특수문자를 각각 1개 이상 포함해 주세요. |
| 400 | nickname이 null·빈 값·공백만 있을 때 | 닉네임을 입력해 주세요. |
| 400 | nickname이 4자 미만이거나 20자를 넘을 때 | 닉네임은 4자 이상 20자 이하로 입력해 주세요. |
| 400 | nickname에 영문·숫자·한글 외 문자(특수문자·공백 등)가 있을 때 | 닉네임은 영문, 숫자, 한글만 사용할 수 있습니다. |
| 409 | 이미 가입된 email일 때 | 이미 사용 중인 이메일입니다. |
| 409 | 이미 사용 중인 nickname일 때 | 이미 사용 중인 닉네임입니다. |

**에러 응답 1:** `400 Bad Request` — email이 null·빈 값·공백만 있을 때

요청

```json
{
  "email": "",
  "password": "password1234!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "이메일을 입력해 주세요.",
  "status": 400
}
```

**에러 응답 2:** `400 Bad Request` — email이 이메일 형식이 아닐 때

요청

```json
{
  "email": "user-example.com",
  "password": "password1234!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "올바른 이메일 형식으로 입력해 주세요.",
  "status": 400
}
```

**에러 응답 3:** `400 Bad Request` — email이 100자를 넘을 때 (예시 값은 앞부분 생략)

요청

```json
{
  "email": "aaaaaaaaaa...aaaaaaaaaa@example.com",
  "password": "password1234!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "이메일은 100자 이하로 입력해 주세요.",
  "status": 400
}
```

**에러 응답 4:** `400 Bad Request` — password가 null·빈 값·공백만 있을 때

요청

```json
{
  "email": "user@example.com",
  "password": "",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "비밀번호를 입력해 주세요.",
  "status": 400
}
```

**에러 응답 5:** `400 Bad Request` — password에 공백 문자가 있을 때

요청

```json
{
  "email": "user@example.com",
  "password": "password 1234!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "비밀번호에는 공백을 사용할 수 없습니다.",
  "status": 400
}
```

**에러 응답 6:** `400 Bad Request` — password가 4자 미만이거나 20자를 넘을 때

요청

```json
{
  "email": "user@example.com",
  "password": "a1!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "비밀번호는 4자 이상 20자 이하로 입력해 주세요.",
  "status": 400
}
```

**에러 응답 7:** `400 Bad Request` — password에 영문·숫자·특수문자 중 하나라도 없을 때

요청

```json
{
  "email": "user@example.com",
  "password": "password1234",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "비밀번호는 영문, 숫자, 특수문자를 각각 1개 이상 포함해 주세요.",
  "status": 400
}
```

**에러 응답 8:** `400 Bad Request` — nickname이 null·빈 값·공백만 있을 때

요청

```json
{
  "email": "user@example.com",
  "password": "password1234!",
  "nickname": ""
}
```

응답

```json
{
  "message": "닉네임을 입력해 주세요.",
  "status": 400
}
```

**에러 응답 9:** `400 Bad Request` — nickname이 4자 미만이거나 20자를 넘을 때

요청

```json
{
  "email": "user@example.com",
  "password": "password1234!",
  "nickname": "gyg"
}
```

응답

```json
{
  "message": "닉네임은 4자 이상 20자 이하로 입력해 주세요.",
  "status": 400
}
```

**에러 응답 10:** `400 Bad Request` — nickname에 영문·숫자·한글 외 문자(특수문자·공백 등)가 있을 때

요청

```json
{
  "email": "user@example.com",
  "password": "password1234!",
  "nickname": "gygim!"
}
```

응답

```json
{
  "message": "닉네임은 영문, 숫자, 한글만 사용할 수 있습니다.",
  "status": 400
}
```

**에러 응답 11:** `409 Conflict` — 이미 가입된 email일 때 (user@example.com 회원이 이미 있음)

요청

```json
{
  "email": "user@example.com",
  "password": "password1234!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "이미 사용 중인 이메일입니다.",
  "status": 409
}
```

**에러 응답 12:** `409 Conflict` — 이미 사용 중인 nickname일 때 (gygim 회원이 이미 있음)

요청

```json
{
  "email": "new@example.com",
  "password": "password1234!",
  "nickname": "gygim"
}
```

응답

```json
{
  "message": "이미 사용 중인 닉네임입니다.",
  "status": 409
}
```
