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
          <b-td><router-link :to="`recipe/${recipe.recipeid}`">{{ recipe.recipename }}</router-link></b-td>
          <b-td>{{ recipe.recipedescription }}</b-td>
          <b-td v-if="recipe.isprivate === true">Private</b-td>
          <b-td v-else>Public</b-td>
          <b-td v-if="recipe.isprivate === true"><b-icon icon="lock-fill" class="rounded bg-primary p-1 h5" variant="light"></b-icon></b-td>
          <b-td v-else><template #button-content><b-icon icon="unlock-fill" aria-hidden="true" class="rounded bg-secondary p-1 h5" variant="light"></b-icon></template></b-td>
          <b-td><b-icon icon="trash-fill" class="rounded bg-secondary p-1 h5" variant="light"></b-icon></b-td>
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
      Api.togglePrivacy(recipeId)
    },
    removeFromCookbook(){

    }
  }
};
</script>
