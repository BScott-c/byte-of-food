import axios from "axios";
import { authHeader } from "./auth";


//const API_URL = `${process.env.BASE_API}`;
const API_URL = 'http://184.169.184.185:8000';

class Api {
  // COOKBOOK ACTIONS
  getCookbooks() {
    return axios.get(API_URL + `/usercookbooks`, {});
  }

  getSingleCookbook(id) {
    return axios.get(API_URL + `/cookbook?cookbookid=eq.${id}`);
  }

  getCookbooksForUser(userid) {
    return axios.get(API_URL + `/usercookbooks?userid=eq.${userid}`, {});
  }

  addCookbook(cookbookName, cookbookDescription, userId) {
    return axios.post(
      API_URL + "/cookbook",
      {
        cookbookname: cookbookName,
        cookbookdescription: cookbookDescription,
        userid: userId
      },
      {
        headers: authHeader(),
      }
    );
  }

  updateCookbook(cookbook) {
    return axios.patch(
      API_URL + `/cookbook?cookbookid=eq.${cookbook.cookbookid}`,
      cookbook,
      {
        headers: authHeader(),
      }
    );
  }

  deleteCookbook(cookbookId) {
    return axios.delete(
      API_URL + `/cookbook?cookbookId=eq.${cookbookId}`,
      {},
      {
        headers: authHeader(),
      }
    );
  }

  // RECIPE - COOKBOOK CALLS
  getRecipesInCookbook(cookbookid) {
    return axios.get(API_URL + `/cookbookrecipes?cookbookid=eq.${cookbookid}`, {});
  }

  getRecipesNotInCookbook(cookbookid) {
    return axios.post(
      API_URL + "/rpc/recipestoaddtocookbook",
      {
        id: `${cookbookid}`
      },
      {
        headers: authHeader(),
      }
    );
  }

  addRecipeToCookbook(cookbookId, recipeId){
    console.log('adding: ', cookbookId, recipeId, 'to cookbook')
    return axios.post(API_URL + `/holds`, 
    {
      cookbookid: cookbookId,
      recipeid: recipeId
    },
    {
      headers: authHeader(),
    });
  }

  removeRecipeFromCookbook(cookbookId, recipeId){
    return axios.delete(API_URL + `/holds?cookbookid=eq.${cookbookId}&recipeid=eq.${recipeId}`, 
    {},
    {
      headers: authHeader(),
    });
  }

  // RECIPE CALLS

  getRecipe(filter){ // Syntax of filter parameter: [{dbparam: 'userid', value: '12345'}]
    let query = '/recipes'
    if (filter.length > 0) query += '?'
    filter.forEach(param => query += `${param.dbparam}=eq.${param.value}&`)
    query = query.substring(0, query.length - 1) // remove & from the end
    return axios.get(API_URL + query)
  }

  updateRecipe(recipeid, body){ // Syntax of filter parameter: [{dbparam: 'userid', value: '12345'}]
    return axios.patch(
      API_URL + `/recipe?recipeid=eq.${recipeid}`,
      body,
      {
        headers: authHeader(),
      }
    );
  }
  
  createRecipe(recipeName, recipeDescription, recipeInstructions, isPrivate, userId) {
    return axios.post(
      API_URL + `/recipe`,
      {
        recipename: recipeName,
        recipedescription: recipeDescription,
        recipeinstructions: recipeInstructions,
        isprivate: isPrivate,
        userid: userId
      },
      {
        headers: authHeader(),
      }
    );
  }

  togglePrivacy(recipeId){
    return axios.post(
      API_URL + "/rpc/toggleprivate",
      {
        id: recipeId
      },
      {
        headers: authHeader(),
      }
    );
  }

  // EQUIPMENT CALLS

  getEquipment(){
    return axios.get(
      API_URL + `/equipment`,
      {},
      {
        headers: authHeader(),
      }
    );
  }

  getRecipeEquipment(recipeId){
    return axios.get(
      API_URL + `/recipeequipment?recipeid=eq.${recipeId}`,
      {},
      {
        headers: authHeader(),
      }
    );
  }

  createEquipment(name, description) {
    return axios.post(
      API_URL + `/equipment`,
      {
        equipmentname: name,
        equipmentdescription: description,
      },
      {
        headers: authHeader(),
      }
    );
  }

  addEquipmentToRecipe(equipmentId, recipeId){
    return axios.post(API_URL + `/involves`, 
    {
      equipmentid: equipmentId,
      recipeid: recipeId
    },
    {
      headers: authHeader(),
    });
  }

  removeEquipmentFromRecipe(equipmentId, recipeId){
    return axios.delete(API_URL + `/involves?equipmentid=eq.${equipmentId}&recipeid=eq.${recipeId}`, 
    {},
    {
      headers: authHeader(),
    });
  }


  // INGREDIENT CALLS


  // ADMINISTRATIVE CALLS

  login(email, password) {
    return axios.post(API_URL + "/rpc/login", { email, password });
  }

  signup(email, firstname, lastname, password) {
    return axios.post(API_URL + "/rpc/signup", { email, firstname, lastname, password });
  }

  getAllUsers() {
    return axios.get(API_URL + "/usertable",
    {},
    {
      headers: authHeader(),
    })
  }

  getAdminStatus(user_id) {
    return axios.get(
      API_URL + `/adminstatus?userid=eq.${user_id}`,
      {

      },
      {
        headers: authHeader(),
      });
  }

  toggleAdminStatus(user_id) {
    return axios.post(
      API_URL + `/rpc/toggleadmin`,
      {
        id: user_id
      },
      {
        headers: authHeader(),
      }
    );
  }

  deleteUser(user_id) {
    return axios.delete(
      API_URL + `/usertable?userid=eq.${user_id}`,
      {},
      {
        headers: authHeader(),
      }
    );
  }
}

export default new Api();
