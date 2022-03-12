<template>
  <div>
    <div>

      <p v-if="this.errors.length">
        <b>Please correct the following error(s):</b>
        <ul>
          <li v-for="error in this.errors" :key="error">{{ error }}</li>
        </ul>
      </p>
      
      <form name="form" @submit.prevent="handleCreate">
        <div class="form-group">
          <label for="recipeName">Recipe Name</label>
          <input
            v-model="recipeName"
            type="text"
            class="form-control"
            name="recipeName"
            required
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
            <b-form-radio-group
              id="privacy"
              v-model="isPrivate"
              :options="options"
              :aria-describedby="ariaDescribedby"
              name="privacy_buttons"
              stacked
              required
            ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="form-group">
          <button class="btn btn-primary btn-block" @click="submit" :disabled="loading">
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
  data: function () {
    return {
      loading: false,
      isPrivate: '',
      recipeName: "",
      recipeDescription: "",
      recipeInstructions: "",
      userId: "",
      options: [
        { text: 'Private', value: true},
        { text: 'Public', value: false}
      ],
      errors: []
    };
  },
  created: function () {
    this.userId = getUserIdFromToken(getJwtToken())
  },
  methods: {
    async handleCreate(e) {
      // TODO: rerun view to include userid
      // check validation
      const recipeNameCheck = await Api.getRecipe([{dbparam: 'userid', value: this.userId}])
      if(recipeNameCheck.every(recipe => {
        recipe.recipename === this.recipeName
      })) this.errors.push('That recipe name already exists. Please try another.')
      
      if (!this.errors.length){
        // create
        await Api.createRecipe(this.recipeName, this.recipeDescription, this.recipeInstructions, this.isPrivate, this.userId)
        // get Id
        const createdRecipe = await Api.getRecipe([{dbparam: 'userid', value: this.userId}, {dbparam: 'recipename', value: this.recipeName}])
        const recipeId = createdRecipe[0].recipeid
        // add
        Api.addRecipeToCookbook(this.$route.params.cookbookid, recipeId)
        this.$emit('return', false) // will set addNew to false
      }

      e.preventDefault();
    }
  }
};
</script>
