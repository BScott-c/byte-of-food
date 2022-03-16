<template>
  <div>
    <div>
      <h1>{{recipe.recipename}}</h1>
      <h3>{{recipe.recipedescription}}</h3>
      <RecipeInstructions v-bind:instructions="recipe.recipeinstructions" v-bind:canEdit="canEdit" v-if="recipe.recipeinstructions"/>
    </div>
  </div>
</template>

<script>
import Api from "../api";
import RecipeInstructions from "../components/RecipeInstructions.vue"
import { getJwtToken, getUserIdFromToken } from '../auth';

export default {
  name: "Recipe",
  components: {
    RecipeInstructions
  },
  data: function () {
    return {
      loading: false,
      canEdit: false,
      recipe: {}
    };
  },
  created: function () {
    this.loading = true;
    Api.getRecipe([{dbparam: 'recipeid', value: this.$route.params.recipeid}]).then(res => {
      console.log('now here')
      this.recipe = {...res.data[0]};
      const userId = getUserIdFromToken(getJwtToken())
      if (res.data[0].userid == userId) this.canEdit = true
      this.loading = false;
    })
  },
  methods: {

  }
};
</script>
