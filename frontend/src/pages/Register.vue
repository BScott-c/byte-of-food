<template>
  <div class="col-md-12">
    <div class="card card-container">
      <img
        id="profile-img"
        src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"
        class="profile-img-card"
      />
      <h1>Byte Of Food</h1>
      <form name="form" @submit.prevent="handleRegister()">
        <div>
          <div class="form-group">
            <label for="userfirstname">First Name</label>
            <input
              v-model="firstName"
              type="text"
              class="form-control"
              firstName="firstName"
              required
            />
          </div>
          <div class="form-group">
            <label for="userlastname">Last Name</label>
            <input
              v-model="lastName"
              type="text"
              class="form-control"
              lastName="lastName"
              required
            />
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input
              v-model="email"
              type="email"
              class="form-control"
              name="email"
              required
            />
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input
              v-model="password"
              type="password"
              class="form-control"
              name="password"
              required
            />
          </div>
          <template v-for="error in this.errors">
            <b-alert show variant="danger" :key="error.id">{{error.message}}</b-alert>
          </template>
          <div class="form-group">
            <button class="btn btn-primary btn-block" type="submit" :disabled="loading">
              <span
                v-show="loading"
                class="spinner-border spinner-border-sm"
              ></span>
              <span>Sign Up</span>
            </button>
          </div>
        </div>
      </form>
      <br>
      <br>
      <div >
        <span>Already have an account?</span>
        <button class="btn btn-primary btn-block" @click="goToLogin()" :disabled="loading">
          <span
            v-show="loading"
            class="spinner-border spinner-border-sm"
          ></span>
          <span>Login</span>
        </button>
      </div>

      <div v-if="message" class="alert alert-danger">
        {{ message }}
      </div>
    </div>
  </div>
</template>

<script>
import Api from "../api";
export default {
  name: "Register",
  data() {
    return {
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      loading: false,
      message: "",
      errors: []
    };
  },
  methods: {
    handleRegister(e) {
      this.invalidPassword()
      if (!this.errors.length) {
        this.message = "";
        this.loading = true;

        Api.signup(this.email, this.firstName, this.lastName, this.password)
          .then(() => {
            console.info('Signed UP without errors and going to login page')
            this.$router.push("/login");
          })
          .catch((error) => {
            console.log(error);
            if (error.response) {
              this.message = error.response.data.message;
            }
            this.loading = false;
          });
        return true
      }
      e.preventDefault()
    },
    goToLogin() {
      this.$router.push('/login')
    },
    invalidPassword() {
      console.log('checking password')
      const passwordErrors = []
      const regex = /(?=^.{8,}$)(?=.*\d)(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/gm
      const matches = regex.exec(this.password);
      if (!matches) {
        passwordErrors.push({id:'passwordError', message: 'Your password must be at least 8 characters and contain at least one digit, uppercase, and lowercase letter.'})
      }
      this.errors = [...passwordErrors]
    }
  },
};
</script>

<style scoped>
label {
  display: block;
  margin-top: 10px;
}

.card-container.card {
  max-width: 350px !important;
  padding: 40px 40px;
}

.card {
  background-color: #f7f7f7;
  padding: 20px 25px 30px;
  margin: 0 auto 25px;
  margin-top: 50px;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
  -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}

.profile-img-card {
  width: 96px;
  height: 96px;
  margin: 0 auto 10px;
  display: block;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
}
</style>