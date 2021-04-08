<template>
  <div id="register" class="text-center">
    <body>
    <form class="registerBox form-register" @submit.prevent="register">
      <h1>Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">{{ registrationErrorMsg }}</div>
      <div class="entries">
      <div class="leftSideEntries">
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <input
        type="password"
        id="confirmPassword"
        class="form-control"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      </div>
      <div class="rightSideEntries">
      <!--Need To Connect-->
      <input type="tel" id="phoneNumber" class="form-control" placeholder="Phone Number" v-model="user.phoneNumber" required />
      <!--Need To Connect-->
      <input type="email" id="email" class="form-control" placeholder="Email" v-model="user.email" required />
      <select name="role" class="dropDownMenu" v-model="user.role" required>
        <option selected="selected" value="user">User</option>
        <option value="landlord">Landlord</option>
        <option value="maintenance">Maintenance</option>
      </select>
      </div>
      </div>
      <input type="submit" class="submit" value="Submit" Create Account />
      <router-link class="loginText" :to="{ name: 'login' }">Have an account?</router-link>
    </form>
    </body>
  </div>
</template>

<script>
import authService from '../services/AuthService';

export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
        phoneNumber: '',
        email: '',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>
<style>
#register{
  background-image: url('../assets/PoolApartment.jpg');
  background-attachment: fixed;
  background-size: cover; 
  margin: -.5rem;
  padding: 0;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  height: 100vh;
}

.registerBox{
  width: 500px;
  padding: 40px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgb(219, 230, 247);
  text-align: center;
  border-radius: 24px;
  border: 2px solid rgb(124, 151, 196);
}

.registerBox h1{
  color: #050e9c;
  text-transform: uppercase;
  font-weight: bold;
}

.registerBox input[type = "text"], .registerBox input[type = "password"], .registerBox input[type = "tel"], .registerBox input[type = "email"], .dropDownMenu{
  border: 0;
  background: none;
  display: block;
  margin: 20px auto;
  text-align: center;
  border: 2px solid #050e9c;
  padding: 14px 10px;
  width: 200px;
  outline: none;
  color: #5f5f5f;
  border-radius: 15px;
  transition: 1s;
  text-align-last:center; 
}

.registerBox input[type = "text"]:focus, .registerBox input[type = "password"]:focus, .registerBox input[type = "tel"]:focus, .registerBox input[type = "email"]:focus{
  width: 220px;
  border-color:#9598c0;
}

.dropDownMenu:focus{
  width: 240px;
  border-color:#9598c0;
}

.registerBox input[type="submit"]{
  border: 0;
  background-color: #5359b1;
  display: block;
  margin: 10px auto;
  text-align: center;
  border: 2px solid #050e9c;
  padding: 10px 20px;
  outline: none;
  color: #ffffff;
  border-radius: 15px;
  transition: 1s;
  cursor: pointer;
}

.loginText{
  text-decoration: none;
}

.leftSideEntries, .rightSideEntries{
  margin: 5px;
}
.entries{
  display: flex;
  flex-direction: row;
  justify-content: center;
}

.dropDownMenu{
  margin: 0;
  width: 224px;
}

@media only screen and (max-width: 60em){
  
}
</style>
