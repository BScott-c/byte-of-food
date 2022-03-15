<template>
  <div>
    <div>
      <h1>{{recipe.recipename}}</h1>
      <h3>{{recipe.recipedescription}}</h3>
      <RecipeInstructions v-bind:instructions="this.recipe.recipeinstructions"/>
    </div>
  </div>
</template>

<script>
import Api from "../api";
import RecipeInstructions from "../components/RecipeInstructions.vue"
// import { getJwtToken, getUserIdFromToken } from '../auth';

export default {
  name: "Recipe",
  components: {
    RecipeInstructions
  },
  data: function () {
    return {
      loading: false,
      recipe: {}
    };
  },
  created: function () {
    this.loading = true;
    Api.getRecipe([{dbparam: 'recipeid', value: this.$route.params.recipeid}]).then(res => {
      console.log('now here')
      this.recipe = {...res.data[0]};
      this.loading = false;
    })
  },
  methods: {

  }
};
</script>
