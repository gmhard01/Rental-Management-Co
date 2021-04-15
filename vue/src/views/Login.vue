<template>
  <div id="login" class="text-center">
    <body>
      <form class="loginBox form-signin" @submit.prevent="login">
        <h1>Sign In</h1>
        <div class="alert alert-danger" role="alert" v-if="invalidCredentials">Invalid username and password!</div>
        <div class="alert alert-success" role="alert" v-if="this.$route.query.registration">Thank you for registering, please sign in.</div>
        <input type="text" name="" placeholder="Username" class="form-control" v-model="user.username" required autofocus>
        <input type="password" id="password" name="" placeholder="Password" class="form-control" v-model="user.password" required autofocus>
        <input type="submit" class="submit" name="" value="Login">
        <router-link :to="{ name: 'register' }" class="registerText">Need an account?</router-link>
      </form>
    </body>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push(this.checkForPropertyPath());
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    },
    checkForPropertyPath() {
      let output = "/";

      if (this.$store.state.currentPropertyPath != "") {        
        output = this.$store.state.currentPropertyPath;        
      }
      else if(this.$store.state.properties != []) {
          output = this.$store.state.currentSearchIndex;
      }

      return output;
    },
    // redirectUser() {
    //   let loginPath = "/login";

    //   this.$router.push("/");
    //   this.$router.go(this.numOfPagesToGoBack);

    //   if (this.$route.path == loginPath) {
    //     this.$router.push("/");
    //   }
    // }
  },
  computed: {
    numOfPagesToGoBack() {
      let output = -2;

      if (this.checkIfPathContainsRegistered) {
        output = -6;
      }

      return output;
    },
    checkIfPathContainsRegistered() {
      let checkPathForRegistration = false;

      if (this.$route.query.registration) {
        checkPathForRegistration = true;
      }

      return checkPathForRegistration;
    },    
  },
};
</script>
<style scoped>

#login{
  background-image: url('../assets/PoolApartment.jpg');
  background-attachment: absolute;
  background-size: cover;
  padding: 0;
  margin: 0;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  height: 100vh;
  width: 100vw;
}

.loginBox{
  width: 300px;
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

.loginBox h1{
  color: #050e9c;
  text-transform: uppercase;
  font-weight: bold;
}

.loginBox input[type = "text"], .loginBox input[type = "password"]{
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
}

.loginBox input[type = "text"]:focus, .loginBox input[type = "password"]:focus{
  width: 280px;
  border-color:#9598c0;
}

.loginBox input[type="submit"]{
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

.registerText{
  text-decoration: none;
}

@media only screen and (max-width: 60em){
.loginBox{
  width: 16em;
  padding: 30px;
  top: 50%;
  left: 50%;
}

.loginBox input[type = "text"]:focus, .loginBox input[type = "password"]:focus{
  width: 230px;
  border-color:#9598c0;
}
}
</style>
