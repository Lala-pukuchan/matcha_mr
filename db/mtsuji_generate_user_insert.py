import uuid
import hashlib
import random

first_names_male = [
    "James", "John", "Robert", "Michael", "William", 
    "David", "Richard", "Joseph", "Charles", "Thomas", 
    "Christopher", "Daniel", "Matthew", "Anthony", "Mark", 
    "Donald", "Steven", "Paul", "Andrew", "Joshua",
    "Kenneth", "Kevin", "Brian", "George", "Timothy", 
    "Ronald", "Edward", "Jason", "Jeffrey", "Ryan",
    "Jacob", "Gary", "Nicholas", "Eric", "Jonathan", 
    "Stephen", "Larry", "Justin", "Scott", "Brandon",
    "Benjamin", "Samuel", "Frank", "Gregory", "Raymond",
    "Alexander", "Patrick", "Jack", "Dennis", "Jerry",
    "Tyler", "Aaron", "Jose", "Adam", "Henry",
    "Nathan", "Douglas", "Zachary", "Peter", "Kyle",
    "Walter", "Ethan", "Jeremy", "Harold", "Keith",
    "Christian", "Roger", "Noah", "Gerald", "Carl",
    "Terry", "Sean", "Austin", "Arthur", "Lawrence"
]
first_names_female = [
    "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", 
    "Barbara", "Susan", "Jessica", "Sarah", "Karen", 
    "Nancy", "Lisa", "Margaret", "Betty", "Sandra", 
    "Ashley", "Dorothy", "Kimberly", "Emily", "Donna", 
    "Michelle", "Carol", "Amanda", "Melissa", "Deborah", 
    "Stephanie", "Rebecca", "Laura", "Sharon", "Cynthia", 
    "Kathleen", "Amy", "Shirley", "Angela", "Helen", 
    "Anna", "Brenda", "Pamela", "Nicole", "Samantha",
    "Katherine", "Emma", "Ruth", "Christine", "Catherine",
    "Debra", "Rachel", "Carolyn", "Janet", "Virginia",
    "Maria", "Heather", "Diane", "Julie", "Joyce",
    "Victoria", "Kelly", "Christina", "Lauren", "Joan",
    "Evelyn", "Olivia", "Judith", "Megan", "Cheryl",
    "Martha", "Andrea", "Frances", "Hannah", "Jacqueline",
    "Ann", "Gloria", "Jean", "Kathryn", "Alice"
]
last_names = [
    "Smith", "Johnson", "Williams", "Brown", "Jones", 
    "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", 
    "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", 
    "Thomas", "Taylor", "Moore", "Jackson", "Martin", 
    "Lee", "Perez", "Thompson", "White", "Harris", 
    "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", 
    "Walker", "Young", "Allen", "King", "Wright", 
    "Scott", "Torres", "Nguyen", "Hill", "Flores", 
    "Green", "Adams", "Nelson", "Baker", "Hall", 
    "Rivera", "Campbell", "Mitchell", "Carter", "Roberts"
]

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
        preference = ""  # 10% の確率でバイセクシャル
    elif orientation_chance <= 20:
        preference = gender  # さらに10% の確率で同性愛者
    else:
        preference = "female" if gender == "male" else "male"  # 残りの80%は異性愛者
 
    lastname = random.choice(last_names)
    username = f"{firstname}{index}"
    email = f"{username.lower()}@example.com"
    password = hashlib.sha256(f"password{index}".encode()).hexdigest()
    enabled = random.choice([0, 1])
    age = random.randint(18, 100)
    biography = f"Hi, I'm {firstname} {lastname}, welcome to my profile!".replace("'", "''")
    pics = [""] * 5
    coordinates = [
        [48.87531185129365, 2.298280405983636],
        [51.50989693654328, -0.10874003178788273],
        [52.51725134473067, 13.402719508063884],
        [52.22540600497236, 21.011485576035128],
        [45.07957378609001, 15.063145528115063],
        [35.841207715466766, 139.82935561320951],
        [2.336185, 48.885884],
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

print("INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`) VALUES")

for i in range(1, 501):
    user_values = generate_user(i)
    values_str = ", ".join([f"'{str(v)}'" if isinstance(v, str) else str(v) for v in user_values])
    end = "," if i < 500 else ";"
    print(f"({values_str}){end}")
