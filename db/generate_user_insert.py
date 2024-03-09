import uuid
import hashlib
import random


def generate_user(index):
    user_id = str(uuid.uuid4())
    email = f"user{index}@example.com"
    username = f"User{index}"
    lastname = f"Last{index}"
    firstname = f"First{index}"
    password = hashlib.sha256(f"password{index}".encode()).hexdigest()
    enabled = random.choice([0, 1])
    age = random.randint(18, 100)
    gender = random.choice(["male", "female"])
    if gender == "male":
        preference = "female"
    else:
        preference = "male"
    biography = f"Biography {index}"
    profilePic = "http://localhost:4000/uploads/icon-1633249_1280.png"
    pics = ["http://example.com/path/to/pic.jpg"] * 5
    coordinates = [
        [48.87531185129365, 2.298280405983636],
        [51.50989693654328, -0.10874003178788273],
        [52.51725134473067, 13.402719508063884],
        [52.22540600497236, 21.011485576035128],
        [45.07957378609001, 15.063145528115063],
        [35.841207715466766, 139.82935561320951]
    ]
    randomCoordinate = coordinates[random.randint(0, 5)]
    latitude = randomCoordinate[0]
    longitude = randomCoordinate[1]
    match_ratio = random.randint(0, 100)
    fake_account = random.choice([0, 1])

    values = (
        user_id,
        email,
        username,
        lastname,
        firstname,
        password,
        enabled,
        age,
        gender,
        preference,
        biography,
        profilePic,
        *pics,
        longitude,
        latitude,
        match_ratio,
        fake_account,
    )
    return values


print(
    "INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`) VALUES"
)

for i in range(1, 501):
    user_values = generate_user(i)
    values_str = ", ".join(
        [f"'{str(v)}'" if isinstance(v, str) else str(v) for v in user_values]
    )
    end = "," if i < 500 else ";"
    print(f"({values_str}){end}")
