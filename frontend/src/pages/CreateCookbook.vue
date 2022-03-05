<template>
  <div class="col-md-12">
    <div class="card card-container">
      <h1>Create a Cookbook</h1>
      <form name="form" @submit.prevent="handleRegister">
        <div>
          <div class="form-group">
            <label for="cookbookName">Cookbook Name</label>
            <input
              v-model="cookbookName"
              type="text"
              class="form-control"
              cookbookName="cookbookName"
            />
          </div>
          <div class="form-group">
            <label for="cookbookDescription">Cookbook Description</label>
            <input
              v-model="cookbookDescription"
              type="text"
              class="form-control"
              cookbookDescription="cookbookDescription"
            />
          </div>
          <div class="form-group">
            <button class="btn btn-primary btn-block" @click="handleCreate()" :disabled="loading">
              <span
                v-show="loading"
                class="spinner-border spinner-border-sm"
              ></span>
              <span>Create</span>
            </button>
          </div>
        </div>
      </form>      
      <div v-if="message" class="alert alert-danger">
        {{ message }}
      </div>
    </div>
  </div>
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from '../auth';

export default {
  name: "CreateCookbook",
  data() {
    return {
      cookbookName: "",
      cookbookDescription: "",
      loading: false,
      message: "",
    };
  },
  methods: {
    handleCreate() {
      this.message = "";
      this.loading = true;
      const userId = getUserIdFromToken(getJwtToken())
      Api.addCookbook(this.cookbookName, this.cookbookDescription, userId)
        .then(() => {
          console.info('Created cookbook without errors and going to user cookbook page')
          this.$router.push(`/`);
        })
        .catch((error) => {
          console.log(error);
          if (error.response) {
            this.message = error.response.data.message;
          }
          this.loading = false;
        });
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