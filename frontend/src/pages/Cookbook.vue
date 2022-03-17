<template>
  <b-container>
    <b-row>
      <b-col>
          <a href='/'>« Back to Cookbooks</a>
        <b-container class="mx-auto h-50 text-center">
        <h1>{{this.cookbook.cookbookname}}</h1>
        <p class="description">
          {{this.cookbook.cookbookdescription}}
        </p>
        </b-container>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-container class="mx-auto mb-2" align-v="center">
        <b-button pill variant="primary" @click="goToAddRecipe()">Add Recipe</b-button>
        </b-container>
        <div v-if="loading">Loading recipes....</div>
        <div v-else>
          <CookbooksRecipeList v-bind:allRecipes="this.recipes" :canEdit="canEdit"/>
        </div>  
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Api from "../api";
import CookbooksRecipeList from "../components/RecipeList.vue"
import { getUserIdFromToken, getJwtToken } from "../auth"
export default {
  name: "Cookbook",
  components: {
    CookbooksRecipeList
  },
  data: function () {
    return {
      loading: false,
      cookbook: {},
      recipes: [],
      canEdit: false
    };
  },
  created: function () {
    Api.getSingleCookbook(this.$route.params.cookbookid).then((res) => {
      console.log(res.data)
      this.cookbook = {...res.data[0]}
    });
    this.loading = true
    Api.getRecipesInCookbook(this.$route.params.cookbookid).then((res) => {
      this.recipes = [...res.data]
      const userId = getUserIdFromToken(getJwtToken())
      if (res.data[0].userid == userId) this.canEdit = true
      this.loading = false;
    })
  },
  methods: {
    goToAddRecipe () {
      this.$router.push(`/addRecipe/${this.cookbook.cookbookid}/${this.cookbook.cookbookname}`)
    }
  }
};
</script>