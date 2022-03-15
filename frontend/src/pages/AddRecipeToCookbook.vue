<template>
  <b-row>
    <b-col>
      <router-link :to="`/cookbook/${this.$route.params.cookbookid}`" >« Back to {{this.$route.params.cookbookname}}</router-link>
      <b-container class="mx-auto text-center">
        <h1>Add a Recipe to <br />{{ this.$route.params.cookbookname }}</h1>
      </b-container>
      <b-container class="mx-auto">
        <b-dropdown
          id="dropdown-left"
          text="Choose method"
          variant="primary"
          class="m-2"
        >
          <b-dropdown-item @click="toggleAddNew(false)"
            >Pick a Recipe</b-dropdown-item
          >
          <b-dropdown-item @click="toggleAddNew(true)"
            >Create a Recipe</b-dropdown-item
          >
        </b-dropdown>
        <hr />
        <div v-if="this.addNew">
          <h2>Create a Recipe...</h2>
          <AddNewRecipe />
        </div>
        <div v-else>
          <h2>Pick a Recipe...</h2>
          <AddExistingRecipe :allRecipes="recipesNotInCookbook"/>
        </div>
      </b-container>
    </b-col>
  </b-row>
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
      message: ""
    };
  },
  created: function () {
    console.log(this.$route);
    this.loading = true;
    Api.getRecipesNotInCookbook(this.$route.params.cookbookid).then((res) => {
      this.recipesNotInCookbook = [...res.data];
      this.loading = false;
    });
  },
  methods: {
    toggleAddNew(bool) {
      this.addNew = bool;
    },
  },
};
</script>
