import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    isLoggedIn: false,
    filter: 0,
    currentIndex: 0,
    properties: [],
  },
  mutations: {
    SET_PROPERTIES(state, propertyArray){
      state.properties = propertyArray;
    },
    GET_PROPERTIES(state){
      return state.properties;
    },
    GET_PROPERTY(state, propId){
      return state.properties.find(element => element.propertyId == propId);
    },
    GET_NEXT_PROPERTY_LIST(state, startingIndex = state.currentIndex, amountToRetreive){
      let start = startingIndex;
      let finish = amountToRetreive;
      if(start + finish >= state.properties.length){
        finish = state.properties.length - start;
      }
      let newPropertyArray = state.properties.slice(start, (start + finish));
      state.currentIndex += finish;
      return newPropertyArray;
    },
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
      state.isLoggedIn = true; 
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
      state.isLoggedIn = false;
    }
  }
})
