"use client";
import { useEffect, useState, ChangeEvent } from "react";
import { useUser } from "../../../context/context";
import {
  validateName,
  isValidLatitude,
  isValidLongitude,
} from "../validations/validation";

export default function UpdateProfile() {
  // set registered user information
  const { user, setUser } = useUser();
  const [selectedGender, setSelectedGender] = useState("");
  const [selectedPreGender, setSelectedPreGender] = useState("");
  const [selectedTagIds, setSelectedTagIds] = useState<number[]>([]); 
  const [latitude, setLatitude] = useState<number | null>(null); 
  const [longitude, setLongitude] = useState<number | null>(null); 

  useEffect(() => {
    if (user) {
      //console.log("user: ", user);
      if (user && user.gender) {
        setSelectedGender(user.gender);
      }
      if (user && user.preference) {
        setSelectedPreGender(user.preference);
      }
      if (user && user.tagIds) {
        const tagIds = Array.isArray(user.tagIds) ? user.tagIds : [user.tagIds];
        const tagArray = tagIds.map((tagId: string) => parseInt(tagId, 10));
        setSelectedTagIds(tagArray);
      }
      if (user && user.latitude) {
        setLatitude(user.latitude);
      }
      if (user && user.longitude) {
        setLongitude(user.longitude);
      }
    }
  }, [user]);

  // set message
  const [message, setMessage] = useState("");

  // set tags
  const [tags, setTags] = useState<any[]>([]); 
  const [inputTag, setInputTag] = useState("");

  // set created tags
  useEffect(() => {
    async function setCreatedTags() {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/tags`
        );
        if (response.status === 200) {
          const data = await response.json();
          setTags(data);
        } else {
          const data = await response.json();
          setMessage(data.message);
        }
      } catch (e) {
        console.error(e);
      }
    }
    setCreatedTags();
  }, []);

  // change add tag value
  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setInputTag(event.target.value);
    setMessage("");
  };

  // handle checked tags
  const handleTags = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { value, checked } = event.target;
    const tagId = parseInt(value, 10);
    if (checked) {
      setSelectedTagIds((prev) => [...prev, tagId]);
    } else {
      setSelectedTagIds((prev) => prev.filter((id) => id !== tagId));
    }
  };

  // add tag
  async function createNewTag() {
    if (inputTag === "") {
      setMessage("Please input tag name.");
    } else {
      const newTagJson = JSON.stringify({ name: inputTag });
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/tags`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: newTagJson,
          }
        );
        if (response.status === 200) {
          const newTag = await response.json();
          setTags([...tags, newTag]);
          setMessage(""); // タグ作成成功時にはエラーメッセージをクリア
        } else if (response.status === 400) {
          // タグがすでに存在する場合のエラーハンドリング
          setMessage("Tag is existing");
        } else {
          const data = await response.json();
          setMessage(data.message);
        }
      } catch (e) {
        console.error(e);
        setMessage("An unexpected error occurred.");
      }
    }
  }

  const addTag = (event: React.FormEvent) => {
    event.preventDefault();
    createNewTag();
    setInputTag("");
  };

  // get current location
  const addGeo = (event: React.FormEvent) => {
    event.preventDefault();
    function setGeo() {
      navigator.geolocation.getCurrentPosition((position) => {
        setLatitude(position.coords.latitude);
        setLongitude(position.coords.longitude);
      });
    }
    setGeo();
  };

  // handle change latitude and longitude
  const handleChangeLatitude = (e: ChangeEvent<HTMLInputElement>) => {
    setLatitude(parseFloat(e.target.value)); 
  };
  const handleChangeLongitude = (e: ChangeEvent<HTMLInputElement>) => {
    setLongitude(parseFloat(e.target.value));
  };

  // submit login form
  async function updateProfile(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const validations = [
      {
        key: "firstname",
        validate: () =>
          validateName(formData.get("firstname") as string, "firstname"),
      },
      {
        key: "lastname",
        validate: () =>
          validateName(formData.get("lastname") as string, "lastname"),
      },
      {
        key: "latitude",
        validate: () =>
          isValidLatitude(parseFloat(formData.get("latitude") as string)),
      },
      {
        key: "longitude",
        validate: () =>
          isValidLongitude(parseFloat(formData.get("longitude") as string)),
      },
    ];
    for (const { validate } of validations) {
      const message = validate();
      if (message !== "") {
        setMessage(message);
        return;
      }
    }
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL}/api/users/user/update`,
        {
          method: "POST",
          body: formData,
          credentials: "include",
        }
      );
      if (response.status === 200) {
        window.location.href = "/myAccount";
      } else {
        const data = await response.json();
        setMessage(data.message);
      }
    } catch (e) {
      console.error(e);
    }
  }

  return (
    <div>
      <form
        onSubmit={updateProfile}
        encType="multipart/form-data"
        className="container mx-auto w-screen"
      >
        <input
          type="text"
          id="userId"
          name="userId"
          defaultValue={user ? user.id : ""}
          className="hidden"
          readOnly
        />
        <div className="flex flex-col m-10 space-y-4">
          <div className="grid grid-cols-2">
            <label htmlFor="lastname" className="font-bold">
              lastname
            </label>
            <input
              type="text"
              id="lastname"
              name="lastname"
              placeholder="lastname"
              required
              defaultValue={user ? user.lastname : ""}
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="firstname" className="font-bold">
              firstname
            </label>
            <input
              type="text"
              id="firstname"
              name="firstname"
              placeholder="firstname"
              required
              defaultValue={user ? user.firstname : ""}
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="email" className="font-bold">
              email
            </label>
            <input
              type="text"
              id="email"
              name="email"
              placeholder="email"
              required
              defaultValue={user ? user.email : ""}
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="age" className="font-bold">
              age
            </label>
            <input
              type="number"
              id="age"
              name="age"
              placeholder="age"
              min={18}
              max={100}
              required
              defaultValue={user ? user.age : ""}
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="gender" className="font-bold">
              Gender
            </label>
            <div className="p-3 rounded">
              <input
                type="radio"
                id="male"
                name="gender"
                value="male"
                className="m-1"
                checked={selectedGender === "male"}
                onChange={() => setSelectedGender("male")}
                required
              />
              <label htmlFor="male">Male</label>
              <input
                type="radio"
                id="female"
                name="gender"
                value="female"
                className="m-1"
                checked={selectedGender === "female"}
                onChange={() => setSelectedGender("female")}
                required
              />
              <label htmlFor="female">Female</label>
            </div>
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="preference" className="font-bold">
              Gender You Like
            </label>
            <div className="p-3 rounded">
              <input
                type="radio"
                id="male-pre"
                name="preference"
                value="male"
                className="m-1"
                checked={selectedPreGender === "male"}
                onChange={() => setSelectedPreGender("male")}
                required
              />
              <label htmlFor="male-pre">Male</label>
              <input
                type="radio"
                id="female-pre"
                name="preference"
                value="female"
                className="m-1"
                checked={selectedPreGender === "female"}
                onChange={() => setSelectedPreGender("female")}
                required
              />
              <label htmlFor="female-pre">Female</label>
              <input
                type="radio"
                id="no-pre"
                name="preference"
                value="no"
                className="m-1"
                checked={selectedPreGender === "no"}
                onChange={() => setSelectedPreGender("no")}
                required
              />
              <label htmlFor="no-pre">No specific</label>
            </div>
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="biography" className="font-bold">
              biography
            </label>
            <input
              type="text"
              id="biography"
              name="biography"
              placeholder="biography"
              required
              defaultValue={user ? user.biography : ""}
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-2">
            <label htmlFor="location" className="font-bold">
              location
            </label>
            <div>
              <input
                type="text"
                id="latitude"
                name="latitude"
                placeholder="latitude"
                required
                value={latitude ? latitude.toString() : ""}
                onChange={handleChangeLatitude}
                className="bg-gray-100 p-3 m-1 rounded"
              />
              <input
                type="text"
                id="longitude"
                name="longitude"
                placeholder="longitude"
                required
                value={longitude ? longitude.toString() : ""}
                onChange={handleChangeLongitude}
                className="bg-gray-100 p-3 m-1 rounded"
              />
              <button
                onClick={addGeo}
                className="m-3 w-15 p-1 h-7 rounded bg-cyan-400 text-white inline-block"
              >
                Get Current Location
              </button>
            </div>
          </div>
          <div className="grid grid-cols-2">
            <div>
              <h2 className="font-bold">Tags</h2>
            </div>
            <div>
              <ul>
                {tags.map((tag) => (
                  <li key={tag.id}>
                    <input
                      id={tag.id}
                      type="checkbox"
                      value={tag.id}
                      name="tags"
                      checked={selectedTagIds.includes(tag.id)}
                      onChange={(event) => handleTags(event)}
                    ></input>
                    <label htmlFor={tag.id} className="pl-2">
                      {tag.name}
                    </label>
                  </li>
                ))}
              </ul>
              <div className="grid grid-cols-2">
                <input
                  type="text"
                  id="addingTag"
                  name="addingTag"
                  value={inputTag}
                  onChange={handleChange}
                  placeholder="#camping"
                  className="bg-gray-100 m-1 p-1 rounded inline-block"
                />
                <button
                  onClick={addTag}
                  className="m-3 w-10 h-7 rounded bg-cyan-400 text-white inline-block"
                >
                  Add
                </button>
              </div>
              {/* error message*/}
              {message && (
                <div className="text-red-500 mt-2">{message}</div>
              )}
            </div>
          </div>
          <div className="grid grid-cols-3">
            <label htmlFor="profilePicture" className="font-bold">
              Profile Picture
            </label>
            <div>
              {user && user.profilePic ? (
                <img
                  src={user.profilePic}
                  alt="Profile Pic"
                  className="h-20 w-20 object-cover rounded"
                />
              ) : (
                <div className="h-20 w-20 bg-gray-200 rounded flex items-center justify-center">
                  No Image
                </div>
              )}
            </div>
            <input
              type="file"
              id="profilePicture"
              name="profilePicture"
              placeholder="profilePicture"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-3">
            <label htmlFor="picture1" className="font-bold">
              Picture1
            </label>
            <div>
              {user && user.pic1 ? (
                <img
                  src={user.pic1}
                  alt="pic1"
                  className="h-20 w-20 object-cover rounded"
                />
              ) : (
                <div className="h-20 w-20 bg-gray-200 rounded flex items-center justify-center">
                  No Image
                </div>
              )}
            </div>
            <input
              type="file"
              id="picture1"
              name="picture1"
              placeholder="picture1"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-3">
            <label htmlFor="picture2" className="font-bold">
              Picture2
            </label>
            <div>
              {user && user.pic2 ? (
                <img
                  src={user.pic2}
                  alt="pic2"
                  className="h-20 w-20 object-cover rounded"
                />
              ) : (
                <div className="h-20 w-20 bg-gray-200 rounded flex items-center justify-center">
                  No Image
                </div>
              )}
            </div>
            <input
              type="file"
              id="picture2"
              name="picture2"
              placeholder="picture2"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-3">
            <label htmlFor="picture3" className="font-bold">
              Picture3
            </label>
            <div>
              {user && user.pic3 ? (
                <img
                  src={user.pic3}
                  alt="pic3"
                  className="h-20 w-20 object-cover rounded"
                />
              ) : (
                <div className="h-20 w-20 bg-gray-200 rounded flex items-center justify-center">
                  No Image
                </div>
              )}
            </div>
            <input
              type="file"
              id="picture3"
              name="picture3"
              placeholder="picture3"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-3">
            <label htmlFor="picture4" className="font-bold">
              Picture4
            </label>
            <div>
              {user && user.pic4 ? (
                <img
                  src={user.pic4}
                  alt="pic4"
                  className="h-20 w-20 object-cover rounded"
                />
              ) : (
                <div className="h-20 w-20 bg-gray-200 rounded flex items-center justify-center">
                  No Image
                </div>
              )}
            </div>
            <input
              type="file"
              id="picture4"
              name="picture4"
              placeholder="picture4"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <div className="grid grid-cols-3">
            <label htmlFor="picture5" className="font-bold">
              Picture5
            </label>
            <div>
              {user && user.pic5 ? (
                <img
                  src={user.pic5}
                  alt="pic5"
                  className="h-20 w-20 object-cover rounded"
                />
              ) : (
                <div className="h-20 w-20 bg-gray-200 rounded flex items-center justify-center">
                  No Image
                </div>
              )}
            </div>
            <input
              type="file"
              id="picture5"
              name="picture5"
              placeholder="picture5"
              accept="image/*"
              className="bg-gray-100 p-3 rounded"
            />
          </div>
          <button　
            type="submit"
            className="w-40 h-9 rounded bg-pink-400 text-white"
          >
            Update
          </button>
          <div className="text-red-500">{message}</div>
        </div>
      </form>
    </div>
  );
}
