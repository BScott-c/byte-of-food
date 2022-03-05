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
          <label for="recipeInstructions">Recipe Instructions</label>
          <input
            v-model="recipeInstructions"
            type="text"
            class="form-control"
            name="recipeInstructions"
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
        <div class="form-group">
          <label for="isPrivate">Privacy</label>
          <br />
          <input
            v-model="isPrivate"
            type="radio"
            id="public"
            value="Public"
            name="isPrivate"
          />
          <label for="public">Public</label>
          <br />
          <input
            v-model="isPrivate"
            type="radio"
            id="private"
            value="Private"
            name="isPrivate"
          />
          <label for="private">Private</label>
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
  },
  data: function () {
    return {
      loading: false,
      isPrivate: Boolean,
      equipmentName: "",
      equipmentDescription: "",
      recipeId: "",
      userId: ""
    };
  },
  created: function () {
    this.userId = getUserIdFromToken(getJwtToken())
  },
  methods: {
    handleCreate() {
      Api.createRecipe(this.recipeName, this.recipeDescription, this.recipeInstructions, this.isPrivate, this.userId)
    }
  }
};
</script>
