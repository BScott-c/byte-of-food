<template>
  <div>
    <div v-if="loading">Loading cookbook....</div>
    <ul v-else>
      <h1>{{cookbook.cookbookname}}</h1>
      <h3>{{cookbook.cookbookdescription}}</h3>
      <li v-for="recipe in recipes" :key="recipe.recipeid">
        <router-link :to="`recipe/${recipe.recipeid}`">{{
          recipe.recipename
        }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "Cookbook",
  data: function () {
    return {
      loading: false,
      cookbook: {},
      recipes: [],
    };
  },
  created: function () {
    Api.getSingleCookbook(this.cookbook.cookbookid).then((res) => {
      this.cookbook = res.data;
    });
    this.loading = true;
    Api.getRecipesInCookbook(this.cookbook.cookbookid).then((res) => {
      this.recipes = res.data;
      this.loading = false;
    });
  },
};
</script>