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
        <template v-for="error in this.errors">
            <b-alert show variant="danger" :key="error.id">{{error.message}}</b-alert>
          </template>
        <div class="form-group">
          <button class="btn btn-primary btn-block" type="submit" :disabled="loading">
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
      // check validation
      await this.nameValidation();
      if (!this.errors.length){
        // create
        await Api.createRecipe(this.recipeName, this.recipeDescription, this.recipeInstructions, this.isPrivate, this.userId)
        // get Id
        const createdRecipe = await Api.getRecipe([{dbparam: 'userid', value: this.userId}, {dbparam: 'recipename', value: this.recipeName}])
        const recipeId = createdRecipe.data[0].recipeid
        // add
        await Api.addRecipeToCookbook(this.$route.params.cookbookid, recipeId)
        this.$router.push(`/cookbook/${this.$route.params.cookbookid}`)
      }

      e.preventDefault();
    },
    async nameValidation () {
      const recipeErrors = []
      const recipeNameCheck = await Api.getRecipe([{dbparam: 'userid', value: this.userId}])
      if(recipeNameCheck.data.find(element => element.recipename === this.recipeName)) recipeErrors.push({id: 'invalidName', message: 'That recipe name already exists. Please try another.'})
      this.errors = [...recipeErrors]
    }
  }
};
</script>
