<template>
  <div>
    <div>
      <form name="form" @submit.prevent="handleCreate">
        <div class="form-group">
          <label for="recipeName">Recipe Name</label>
          <input
            v-model="recipeName"
            type="text"
            class="form-control"
            name="recipeName"
          />
        </div>
        <div class="form-group">
          <label for="recipeDescription">Recipe Description</label>
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
      </form>
    </div>
  </div>
</template>

<script>
import Api from "../api"
import { getJwtToken, getUserIdFromToken } from '../auth';

export default {
  name: "AddNewRecipe",
  props: {
    addNew: Boolean
  },
  data: function () {
    return {
      loading: false,
      isPrivate: Boolean,
      recipeName: "",
      recipeDescription: "",
      recipeInstructions: "",
      userId: ""
    };
  },
  created: function () {
    this.userId = getUserIdFromToken(getJwtToken())
  },
  methods: {
    async handleCreate() {
      await Api.createRecipe(this.recipeName, this.recipeDescription, this.recipeInstructions, this.isPrivate, this.userId)
      this.addNew = !this.addNew
    }
  }
};
</script>
