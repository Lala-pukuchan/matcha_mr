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
    gender = random.choice(["male", "female", "other"])
    preference = random.choice(["male", "female", "both", "none"])
    biography = f"Biography {index}"
    profilePic = "http://localhost:4000/uploads/icon-1633249_1280.png"
    pics = ["http://example.com/path/to/pic.jpg"] * 5
    longitude = random.uniform(-180, 180)
    latitude = random.uniform(-90, 90)
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
