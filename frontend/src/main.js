import Vue from "vue";
import VueRouter from "vue-router";
import { BootstrapVue, IconsPlugin } from "bootstrap-vue";

import App from "./App.vue";
import Home from "./pages/Home";
import Admin from "./pages/Admin";
import Login from "./pages/Login";
import Logout from "./pages/Logout";
import Register from "./pages/Register";
import Cookbook from "./pages/Cookbook";
import AllCookbooks from "./pages/AllCookbooks"
import CreateCookbook from "./pages/CreateCookbook"
import CreateRecipe from "./pages/CreateRecipe"
import AddRecipeToCookbook from "./pages/AddRecipeToCookbook"
import AppBar from "./components/AppBar.vue"
import AdminArticleAdd from "./components/AdminArticleAdd";
import AdminArticleList from "./components/AdminArticleList";
import AdminArticleEdit from "./components/AdminArticleEdit";

import DefaultLayout from './layouts/Default.vue';
import PlainLayout from './layouts/Plain.vue';

Vue.component('default-layout', DefaultLayout);
Vue.component('plain-layout', PlainLayout);

Vue.config.productionTip = false;

import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
import { getJwtToken } from "./auth";

Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(VueRouter);

const checkAuth = function(to, _, next) {
  const token = getJwtToken();
  console.log('CHECK AUTH TOKEN: ', token)
  if (token === undefined || token === "undefined" || token === null) {
    // redirect to login because we don't have token yet
    next({
      path: "/login",
      params: { nextUrl: to.fullPath },
    });
  } else {
    next();
  }
};

const router = new VueRouter({
  routes: [
    {  
      path: "/", // Shows User's Cookbooks
      component: Home,
      beforeEnter: checkAuth
   },
   {  
    path: "/cookbook/create", 
    component: CreateCookbook,
    beforeEnter: checkAuth
    },
    {  
      path: "/recipe/create/:cookbookid?", 
      component: CreateRecipe,
      beforeEnter: checkAuth
      },
    {  
      path: "/addRecipe/:cookbookid/:cookbookname", 
      component: AddRecipeToCookbook,
      beforeEnter: checkAuth
      },
    { 
      path: "/usercookbooks/:userid", 
      component: AllCookbooks,
      beforeEnter: checkAuth
    }, // get all cookbooks for user
    // { 
    //   path: "/recipe/:recipeid", 
    //   component: SingleRecipe,
    //   beforeEnter: checkAuth
    // },
    { 
      path: "/cookbook/:cookbookid",
      name: "Cookbook",
      component: Cookbook,
      beforeEnter: checkAuth
    }, // get all recipes in a cookbook
    // { path: "/recipes/:userid", component: Recipe }, // get all recipes for user
    // { path: "/recipe/:recipeid", component: Cookbook }, // get a single recipe
    // { path: "/favoriteRecipes/:userid", component: Cookbook }, // get all favorite recipe
    {
      path: "/login",
      component: Login,
      meta: { layout: "plain-layout" }
    },
    {
      path: "/logout",
      component: Logout,
      meta: { layout: "plain-layout" }
    },
    { path: "/register", component: Register },
    {
      path: "/admin",
      component: Admin,
      children: [
        { path: "add", component: AdminArticleAdd },
        { path: "edit/:id", component: AdminArticleEdit },
        { path: "", component: AdminArticleList },
        { path: "", component: AppBar}
      ],
    },
  ],
});

new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
