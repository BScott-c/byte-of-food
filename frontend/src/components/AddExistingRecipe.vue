<template>
  <div>
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th></b-th>
          <b-th>Name</b-th>
          <b-th>Description</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="recipe in this.allRecipes" :key="recipe.recipeid">
          <template v-if="canAddRecipe(recipe.userid, recipe.isprivate)">
          <b-td><button @click="addRecipe(recipe.recipeid)">+</button></b-td>
          <b-td>{{recipe.recipename}}</b-td>
          <b-td>{{ recipe.recipedescription }}</b-td>
          </template>
        </b-tr>
      </b-tbody>
    </b-table-simple>
    <div v-if="!this.allRecipes.length">
      <b-alert show variant="info">There are no more recipes to add!</b-alert>
    </div>
  </div>
</template>

<script>
import Api from "../api"
import { getJwtToken, getUserIdFromToken } from '../auth';

export default {
  name: "AddExistingRecipe",
  props: {
    allRecipes:{
      type: Array,
      required: true
    }
  },
  data() {
    return {
      userId: Number,
      test: 'this'
    };
  },
  created: function () {
    this.userId = getUserIdFromToken(getJwtToken())
    console.log(this.userId)
  },
  methods: {
    canAddRecipe (recipe_userId, recipe_isprivate){
      console.log(recipe_userId == this.userId, !recipe_isprivate)
      return (recipe_userId == this.userId || !recipe_isprivate)
    },
    addRecipe(recipeid) {
      const cookbookid = this.$route.params.cookbookid
      Api.addRecipeToCookbook(cookbookid, recipeid).then(() => {
        // reload recipes
        Api.getRecipesNotInCookbook(cookbookid).then (res => {
          console.log('before: ', this.allRecipes)
          this.allRecipes = [...res.data]
          console.log('after: ', this.allRecipes)
        })
      })
    }
  }
};
</script>
