<template>
  <div>
    
    
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Name</b-th>
          <b-th>Description</b-th>
          <b-th>Privacy</b-th>
          <b-th></b-th>
          <b-th></b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="recipe in allRecipes" :key="recipe.recipeid">
          <b-td><router-link :to="`/recipe/${recipe.recipeid}`">{{ recipe.recipename }}</router-link></b-td>
          <b-td>{{ recipe.recipedescription }}</b-td>
          <b-td v-if="recipe.isprivate === true">Private</b-td>
          <b-td v-else>Public</b-td>
          <b-td v-if="recipe.isprivate === true">
            <b-button-group class="mr-1">
              <b-button @click="togglePrivacy(recipe.recipeid)" title="Private" class="rounded bg-primary p-1">
                  <b-icon icon="lock-fill" variant="light" aria-hidden="true"></b-icon>
              </b-button>
            </b-button-group>  
          </b-td>
          <b-td v-else>
            <b-button-group class="mr-1">
              <b-button @click="togglePrivacy(recipe.recipeid)" title="Public" class="rounded bg-secondary p-1">
                  <b-icon icon="unlock-fill" variant="light" aria-hidden="true"></b-icon>
              </b-button>
            </b-button-group>
          </b-td>
          <b-td>
            <b-button-group class="mr-1">
              <b-button @click="removeFromCookbook(recipe.recipeid)" title="Remove Recipe" class="rounded bg-secondary p-1">
                  <b-icon icon="trash-fill" variant="light" aria-hidden="true"></b-icon>
              </b-button>
            </b-button-group>
          </b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>

    
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "RecipeList",
  props: {
    allRecipes: {
      type: Array,
      required: true
    }
  },
  methods: {
    togglePrivacy(recipeId){
      Api.togglePrivacy(recipeId).then(() => {
        // reload recipes on page
        Api.getRecipesInCookbook(this.$route.params.cookbookid).then(res => {
          this.allRecipes = [...res.data]
        })
      })
    },
    removeFromCookbook(recipeId){
      Api.removeRecipeFromCookbook(this.$route.params.cookbookid, recipeId).then(() => {
        // reload recipes on page
        Api.getRecipesInCookbook(this.$route.params.cookbookid).then(res => {
          this.allRecipes = [...res.data]
        })
      })
    }
  }
};
</script>
