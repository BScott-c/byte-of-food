<template>
  <!-- <div class="col-md-12"> -->
  <b-card title="Create A Cookbook">      
      <div v-if="message" class="alert alert-danger">
        {{ message }}
      </div>
    <b-form @submit="handleCreate" @reset="onReset">
      <b-form-group
        id="input-group-1"
        label="CookBook Name:"
        label-for="input-1"
      >
        <b-form-input
          id="input-1"
          v-model="cookbookName"
          placeholder="Cookbook Name"
          required
        ></b-form-input>
      </b-form-group>

      <b-form-group
        id="input-group-2"
        label="Cookbook Description:"
        label-for="input-2"
      >
        <b-form-textarea
          id="input-2"
          v-model="cookbookDescription"
          placeholder="Write a description..."
          rows=4
        ></b-form-textarea>
      </b-form-group>
      <b-button pill type="submit" variant="primary">Submit</b-button>
      <span>&nbsp;</span>
      <b-button pill type="reset" variant="danger">Reset</b-button>
    </b-form>
    <b-link to="/" class="card-link"> Return back to cookbooks </b-link>
  </b-card>
  <!-- <div class="card card-container">
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
    </div> -->
  <!-- </div> -->
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from "../auth";

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
      const userId = getUserIdFromToken(getJwtToken());
      Api.addCookbook(this.cookbookName, this.cookbookDescription, userId)
        .then(() => {
          console.info(
            "Created cookbook without errors and going to user cookbook page"
          );
          this.$router.push(`/`);
        })
        .catch((error) => {
          console.log(error);
          if (error.response) {
            this.message = error.response.data.message;
          }
          this.loading = false;
        });

    },
    onReset() {
      console.info(
        "Clearing user inputed data."
      )
      this.cookbookName = "";
      this.cookbookDescription = "";
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