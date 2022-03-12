<template>
  <b-row>
    <b-col>
      <a href="/">« Back to Cookbook</a>
      <b-container class="mx-auto text-center">
        <h1>{{this.$route.params.cookbookname}}</h1>
      </b-container>
      <b-container class="mx-auto">
        <b-button pill variant="primary" @click="toggleAddNew()">
          <span v-if="this.addNew">
          Pick a Recipe
          </span>
          <span v-else>
          Create a Recipe
          </span>
          </b-button>
        <hr/>
        <p>
          Or if your recipe exists in another cookbook...  
        </p>
        <hr/>
      <div v-if="this.addNew">
        <h2>Create a Recipe...</h2>
        <AddNewRecipe @return="toggleAddNew()" />
      </div>
      <div v-else>
        <h2>Pick a Recipe...</h2>
        <AddExistingRecipe v-bind:allRecipes="recipesNotInCookbook"/>
      </div>
      </b-container>
    </b-col>
  </b-row>
  <!-- <div >
    <div>
      <h1>Add a Recipe to "{{this.$route.params.cookbookname}}"</h1>  
      <div v-if="this.addNew">
        <AddNewRecipe @return="toggleAddNew()" />
      </div>
      <div v-else>
        <AddExistingRecipe v-bind:allRecipes="recipesNotInCookbook"/>
        <br /><br />
        <p>Don't see your recipe? </p>
        <button @click="toggleAddNew()">Create a Recipe</button>
      </div>
    </div>
  </div> -->
</template>

<script>
import Api from "../api";
import AddExistingRecipe from "../components/AddExistingRecipe.vue";
import AddNewRecipe from "../components/AddNewRecipe.vue";

export default {
  name: "AddRecipeToCookbook",
  components: {
    AddExistingRecipe,
    AddNewRecipe,
  },
  data() {
    return {
      recipesNotInCookbook: [],
      loading: false,
      addNew: false,
      message: "",
    };
  },
  created: function () {
    console.log(this.$route);
    this.loading = true;
    Api.getRecipesNotInCookbook(this.$route.params.cookbookid).then((res) => {
      this.recipesNotInCookbook = [...res];
      this.loading = false;
    });
  },
  methods: {
    toggleAddNew() {
      this.addNew = !this.addNew;
    },
  },
};
</script>
