import uuid
import hashlib
import random

first_names_male = [
    "James", "John", "Robert", "Michael", "William", 
    # ... (other names)
]
first_names_female = [
    "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", 
    # ... (other names)
]
last_names = [
    "Smith", "Johnson", "Williams", "Brown", "Jones", 
    # ... (other names)
]

def generate_user(index):
    user_id = str(uuid.uuid4())
    gender = random.choice(["male", "female"])
    if (gender == "male"):
        firstname = random.choice(first_names_male)
        profile_pic_index = random.randint(1, 12)
        profilePic = f"http://localhost:4000/uploads/{profile_pic_index}_boy.png"
    else:
        firstname = random.choice(first_names_female)
        profile_pic_index = random.randint(1, 12)  
        profilePic = f"http://localhost:4000/uploads/{profile_pic_index}_girl.png"

    orientation_chance = random.randint(1, 100)
    if orientation_chance <= 10:
        preference = ""  # 10% chance of bisexual
    elif orientation_chance <= 20:
        preference = gender  # 10% chance of same-sex preference
    else:
        preference = "female" if gender == "male" else "male"  # 80% chance of opposite sex preference

    lastname = random.choice(last_names)
    username = f"{firstname}{index}"
    email = f"{username.lower()}@example.com"
    password = hashlib.sha256(f"password{index}".encode()).hexdigest()
    enabled = random.choice([0, 1])
    age = random.randint(18, 100)
    biography = f"Hi, I'm {firstname} {lastname}, welcome to my profile!".replace("'", "''")
    pics = [""] * 5
    coordinates = [
        [2.298280405983636, 48.87531185129365],
        # ... (other coordinates)
    ]

    randomCoordinate = random.choice(coordinates)
    latitude, longitude = randomCoordinate
    match_ratio = random.randint(0, 100)
    fake_account = random.choice([0, 1])
    isRealUser = 0  # Set to 0 as per your schema
    status = "offline"  # Default value as per your schema

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
        isRealUser,
        status,
        None  # last_active (NULL)
    )
    return values

print("INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `isRealUser`, `status`, `last_active`) VALUES")

for i in range(1, 501):
    user_values = generate_user(i)
    values_str = ", ".join([f"'{str(v)}'" if isinstance(v, str) or v is None else str(v) for v in user_values])
    end = "," if i < 500 else ";"
    print(f"({values_str}){end}")
