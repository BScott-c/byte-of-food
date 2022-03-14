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
          <b-td><button @click="addRecipe(recipe.recipeid)">+</button></b-td>
          <b-td>{{recipe.recipename}}</b-td>
          <b-td>{{ recipe.recipedescription }}</b-td>
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

export default {
  name: "AddExistingRecipe",
  props: {
    allRecipes: {
      type: Array,
      required: true
    }
  },
  methods: {
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
