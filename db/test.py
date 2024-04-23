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
        preference = "female"
        profile_pic_index = random.randint(1, 12)
        profilePic = f"http://localhost:4000/uploads/{profile_pic_index}_boy.png"
    else:
        firstname = random.choice(first_names_female)
        preference = "male"
        profile_pic_index = random.randint(1, 12)  
        profilePic = f"http://localhost:4000/uploads/{profile_pic_index}_girl.png"
    
    lastname = random.choice(last_names)
    username = f"{lastname}{index}"
    email = f"{username.lower()}@example.com"
    password = hashlib.sha256(f"password{index}".encode()).hexdigest()
    enabled = random.choice([0, 1])
    age = random.randint(18, 100)
    biography = f"Biography of {firstname} {lastname}"
    pics = [f"https://example.com/path/to/pic{i}.jpg" for i in range(1, 6)]
    coordinates = [
        [48.87531185129365, 2.298280405983636],
        [51.50989693654328, -0.10874003178788273],
        [52.51725134473067, 13.402719508063884],
        [52.22540600497236, 21.011485576035128],
        [45.07957378609001, 15.063145528115063],
        [35.841207715466766, 139.82935561320951]
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
