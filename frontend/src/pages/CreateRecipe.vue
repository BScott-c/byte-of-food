<template>
  <div>
    <div>
      <AddNewRecipe />
      <!-- <form name="form" @submit.prevent="handleCreate">
        <div class="form-group">
          <label for="recipeName">Name</label>
          <input
            v-model="recipeName"
            type="text"
            class="form-control"
            name="recipeName"
          />
        </div>
        <div class="form-group">
          <label for="recipeDescription">Description</label>
          <input
            v-model="recipeDescription"
            type="text"
            class="form-control"
            name="recipeDescription"
          />
        </div>
        <div>
          <b-form-group label="Privacy" v-slot="{ ariaDescribedby }">
            <b-form-radio v-model="isPrivate" :aria-describedby="ariaDescribedby" name="Public" value="false">Public</b-form-radio>
            <b-form-radio v-model="isPrivate" :aria-describedby="ariaDescribedby" name="Private" value="true">Private</b-form-radio>
          </b-form-group>
        </div>
        <div class="form-group">
          <button class="btn btn-primary btn-block" @click="handleCreate()" :disabled="loading">
            <span
              v-show="loading"
              class="spinner-border spinner-border-sm"
            ></span>
            <span>Create and Add Recipe</span>
          </button>
        </div>
        <br>
        <br>
      </form> -->
    </div>
  </div>
</template>

<script>
import Api from "../api";
import { getJwtToken, getUserIdFromToken } from '../auth';
import AddNewRecipe from "../components/AddNewRecipe.vue";

export default {
  name: "CreateRecipe",
  components: {
    AddNewRecipe
  },
  data: function () {
    return {
      loading: false,
      cookbookid: "",
      recipeName: "",
      recipeDescription: "",
      isPrivate: Boolean
    };
  },
  created: function () {
    if (this.$route.params.cookbookid) {
      this.cookbookid = this.$route.params.cookbookid
    }
  },
  methods: {
    handleCreate() {
      const userId = getUserIdFromToken(getJwtToken())
      Api.createRecipe(this.recipeName, this.recipeDescription, "", this.isPrivate, userId) // leave recipeInstructions blank
    }
  }
};
</script>
