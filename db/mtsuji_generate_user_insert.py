import uuid
import hashlib
import random
from datetime import datetime, timedelta

first_names_male = [
    "James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas",
    "Daniel", "Paul", "Mark", "George", "Steven", "Edward", "Brian", "Ronald", "Anthony", "Kevin",
    "Hiroshi", "Kazuo", "Satoshi", "Yuki", "Ren", "Étienne", "Olivier", "Louis", "Pierre", "Julien",
    "Pierre", "Alexandre", "Thomas", "François", "Jacques", "Henri", "Gérard", "Philippe", "Bernard", "Michel"
]
first_names_female = [
    "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen",
    "Nancy", "Betty", "Lisa", "Sandra", "Helen", "Maria", "Kimberly", "Donna", "Michelle", "Emily",
    "Aiko", "Sakura", "Yuki", "Hana", "Miyu", "Camille", "Marie", "Claire", "Sophie", "Chloé", "Ruru", "Mika",
    "Maki", "Yumi", "Yuriko", "Yuko", "Agnès", "Élise", "Léa", "Manon", "Sarah"
]
last_names = [
    "Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Martinez",
    "Anderson", "Taylor", "Thomas", "Hernandez", "Moore", "Martin", "Jackson", "Thompson", "White", "Lopez",
    "Suzuki", "Takahashi", "Tanaka", "Yamamoto", "Kobayashi", "Durand", "Lefevre", "Bernard", "Moreau", "Dubois",
    "Sato", "Saito", "Tsuji", "Bonnet", "Aoki", "Sawai", "Ono", "Kawasaki", "Nakamura", "Kato"
]

tags = [
    "camping", "fighting", "music", "piano", "study", "surf", "wine",
    "Yoga", "Vegan", "Vintage", "Art Galleries", "Biking", "Organic Food", 
    "Street Art", "Photography", "Minimalism", "Indie Films", "Local Markets", 
    "Sustainability", "Craft Beer", "Alternative Music", "Meditation", 
    "Book Clubs", "Farmers Markets", "Artisanal Coffee", "Second-Hand Shopping", 
    "Concept Stores", "Programming"
]

def generate_last_active():
    start_date = datetime(2024, 5, 1)
    end_date = datetime(2024, 8, 16)
    return start_date + (end_date - start_date) * random.random()

def assign_tags(gender, preference):
    male_tags = ["fighting", "surf", "camping", "Craft Beer", "Biking"]
    female_tags = ["Yoga", "Vegan", "Vintage", "Art Galleries", "Meditation", ]
    neutral_tags = [
        "music", "piano", "study", "wine", "Photography", "Street Art", "Programming",
        "Indie Films", "Local Markets", "Sustainability", "Book Clubs",
        "Farmers Markets", "Artisanal Coffee", "Second-Hand Shopping", "Concept Stores"
    ]
    
    selected_tags = []
    
    if gender == "male" and preference == "male":
        selected_tags += random.sample(male_tags + neutral_tags, random.randint(0, 5))
    elif gender == "female" and preference == "female":
        selected_tags += random.sample(female_tags + neutral_tags, random.randint(0, 5))
    elif preference == "no":
        selected_tags += random.sample(male_tags + female_tags + neutral_tags, random.randint(0, 5))
    else:
        selected_tags += random.sample(neutral_tags, random.randint(0, 5))
    
    return list(set(selected_tags))  # Remove duplicates if any

def generate_user(index):
    user_id = str(uuid.uuid4())
    gender = random.choice(["male", "female"])
    if gender == "male":
        firstname = random.choice(first_names_male)
        profile_pic_index = random.randint(1, 12)
        profilePic = f"http://localhost:4000/uploads/{profile_pic_index}_boy.png"
    else:
        firstname = random.choice(first_names_female)
        profile_pic_index = random.randint(1, 12)  
        profilePic = f"http://localhost:4000/uploads/{profile_pic_index}_girl.png"

    orientation_chance = random.randint(1, 100)
    if orientation_chance <= 10:
        preference = "no"  # 10% chance of bisexual
    elif orientation_chance <= 20:
        preference = gender  # 10% chance of same-sex preference
    else:
        preference = "female" if gender == "male" else "male"  # 80% chance of opposite sex preference

    lastname = random.choice(last_names)
    username = f"{firstname}{index}"
    email = f"{username.lower()}@example.com"
    password = hashlib.sha256(f"password{index}".encode()).hexdigest()
    enabled = random.choice([0, 1])
    age = random.randint(18, 65)
    biography = f"Hi, I'm {firstname} {lastname}, welcome to my profile!".replace("'", "''")
    pics = [""] * 5
    coordinates = [
        [45.764043, 4.835659],
        [43.296482, 5.369780],
        [43.710173, 7.261953],
        [48.573405, 7.752111],
        [44.837789, -0.579180],
        [47.218371, -1.553621],
        [50.629250, 3.057256],
        [43.604652, 1.444209],
        [43.610769, 3.876716],
        [49.443232, 1.099971],
        [49.258329, 4.031696],
        [48.390394, -4.486076],
        [49.894067, 2.295753],
        [45.777222, 3.087025],
        [43.483152, -1.558626],
        [34.693738, 135.502165],
        [35.181446, 136.906398],
        [43.062096, 141.354376],
        [33.590355, 130.401716],
        [38.268215, 140.869356],
        [34.385203, 132.455293],
        [37.916192, 139.036413],
        [34.971855, 138.388475],
        [34.655146, 133.919502],
        [31.596554, 130.557116],
        [35.443708, 139.638026],
        [36.561325, 136.656205],
        [34.690083, 135.195511],
        [26.212401, 127.680932],
        [35.011636, 135.768029],
        [40.712776, -74.005974],
        [34.052235, -118.243683],
        [41.878113, -87.629799],
        [29.760427, -95.369804],
        [33.448377, -112.074037],
        [39.952584, -75.165222],
        [29.424122, -98.493629],
        [32.715738, -117.161084],
        [32.776664, -96.796988],
        [37.338208, -121.886329],
        [30.267153, -97.743061],
        [30.332184, -81.655651],
        [37.774929, -122.419416],
        [39.961176, -82.998794],
        [35.227087, -80.843127],
        [50.850346, 4.351721],
        [51.219448, 4.402464],
        [51.054342, 3.717424],
        [40.416775, -3.703790],
        [41.385064, 2.173404],
        [37.389092, -5.984459]
    ]

    randomCoordinate = random.choice(coordinates)
    latitude, longitude = randomCoordinate
    match_ratio = 0
    fake_account = random.choice([0, 1])
    isRealUser = 0  # Set to 0 as per your schema
    status = "offline"  # Default value as per your schema

    tags = assign_tags(gender, preference)
    last_active = generate_last_active().strftime('%Y-%m-%d %H:%M:%S')

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
        isRealUser,  # Moved isRealUser before pic1
        status,      # Moved status before pic1
        *pics,
        longitude,
        latitude,
        match_ratio,
        fake_account,
        last_active
    )
    return values, tags

# 出力するSQLステートメントを保存するリスト
insert_user_statements = []
insert_tag_statements = []

for i in range(1, 501):
    user_values, user_tags = generate_user(i)
    values_str = ", ".join([f"'{str(v)}'" if isinstance(v, str) or v is None else str(v) for v in user_values])
    insert_user_statements.append(f"({values_str})")

    if user_tags:
        for tag in user_tags:
            tag_id = tags.index(tag) + 23  # Adjusting for the ID range
            insert_tag_statements.append(f"('{user_values[0]}', '{tag_id}')")

# すべてのINSERT文を出力
print("INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `isRealUser`, `status`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `last_active`) VALUES")
print(",\n".join(insert_user_statements) + ";")
print("INSERT INTO `usertag` (`user_id`, `tag_id`) VALUES")
print(",\n".join(insert_tag_statements) + ";")