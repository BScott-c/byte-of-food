import axios from "axios";
import { authHeader, getJwtToken, getUserIdFromToken } from "./auth";


//const API_URL = `${process.env.BASE_API}`;
const API_URL = 'http://184.169.184.185:8000';

class Api {
  getCookbooks() {
    return axios.get(API_URL + `/usercookbooks`, {});
  }

  getCookbooksForUser(userid) {
    return axios.get(API_URL + `/usercookbooks?userid=eq.${userid}`, {});
  }

  getSingleCookbook(id) {
    return axios.get(API_URL + `/cookbook?cookbookid=eq.${id}`);
  }

  addCookbook(cookbook) {
    return axios.post(
      API_URL + "/cookbook",
      {
        ...cookbook,
        // add user id from JWT token
        userid: getUserIdFromToken(getJwtToken()),
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

  getRecipesInCookbook(cookbookid) {
    return axios.get(API_URL + `/cookbookrecipes?cookbookid=eq.${cookbookid}`, {});
  }

  // deleteArticle(id) {
  //   return axios.delete(API_URL + `/articles?articleid=eq.${id}`, {
  //     headers: authHeader(),
  //   });
  // }

  login(email, password) {
    return axios.post(API_URL + "/rpc/login", { email, password });
  }

  signup(email, firstname, lastname, password) {
    return axios.post(API_URL + "/rpc/signup", { email, firstname, lastname, password });
  }
}

export default new Api();
