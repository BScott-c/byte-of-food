<template>
  <div>
    <h1>{{this.cookbook.cookbookname}}</h1>
    <h3>{{this.cookbook.cookbookdescription}}</h3>
    <br /><br />
    <button @click="goToAddRecipe()">Add Recipe</button>
    <div v-if="loading">Loading recipes....</div>
    <div v-else><CookbooksRecipeList v-bind:allRecipes="this.recipes"/></div>
  </div>
</template>

<script>
import Api from "../api";
import CookbooksRecipeList from "../components/RecipeList.vue"

export default {
  name: "Cookbook",
  components: {
    CookbooksRecipeList
  },
  data: function () {
    return {
      loading: false,
      cookbook: {},
      recipes: []
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