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
    filter: 0,
    currentIndex: 0,
    properties: [],
    currentPropertyPath: '',
    currentSearchIndex: '',
    currentProperty: {},
    userRentalProperty: {},
    userTransactions: {},
    userUpcomingPayments: {},
    propertyMaintenanceRequest: {},
    landlordPropertiesList: [],
    landlordApplicationsForProperty: {},
    landlordTransactionsForProperty: {},
    landlordMaintenanceRequestForProperty: {},
  },
  mutations: {
    SET_PROPERTIES(state, propertyArray){
      state.properties = propertyArray;
    },
    // GET_PROPERTIES(state){
    //   return state.properties;
    // },
    SET_PROPERTY(state, property){
      state.currentProperty = property;
    },
    REMOVE_DATA_FOR_CURRENT_LANDLORD_PROPERTY_FROM_STORE(state) {
      state.currentProperty = {};
      state.landlordTransactionsForProperty = {};
      state.landlordMaintenanceRequestForProperty = {};
      state.landlordApplicationsForProperty = {};
    },
    SET_LANDLORD_PROPERTIES(state, propertyList) {
      state.landlordPropertiesList = propertyList;
    },
    SET_LANDLORD_PROPERTY_MAINTENANCE(state, requestList) {
      state.landlordMaintenanceRequestForProperty = requestList;
    },
    SET_LANDLORD_PROPERTY_TRANSACTIONS(state, transactionList) {
      state.landlordTransactionsForProperty = transactionList;
    },
    SET_LANDLORD_PROPERTY_APPLICATIONS(state, applicationsList) {
      state.landlordApplicationsForProperty = applicationsList;
    },
    SET_USER_RENTAL_PROPERTY(state, rentalProperty) {
      state.userRentalProperty = rentalProperty;
    },
    SET_USER_TRANSACTIONS(state, transactionList) {
      state.userTransactions = transactionList;
    },
    SET_USER_UPCOMING_PAYMENTS(state, upcomingPayments) {
      state.userUpcomingPayments = upcomingPayments;
    },
    SAVE_CURRENT_ROUTE(state, currentPropertyPath) {
      state.currentPropertyPath = currentPropertyPath;
    },
    SET_MAINTENANCE_PROPERTIES(state, property) {
      state.propertyMaintenanceRequest = property;
    },
    REMOVE_CURRENT_ROUTE(state) {
      state.currentPropertyPath = '';
    },
    SAVE_CURRENT_SEARCH_INDEX(state, currentSearchIndex){
      state.currentSearchIndex = currentSearchIndex;
    },
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user)); 
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
      state.userRentalProperty = {};
      state.userTransactions = {};
      state.propertyMaintenanceRequest = {};
      state.landlordPropertiesList = [];
      state.landlordApplicationsForProperty = {};
      state.landlordTransactionsForProperty = {};
      state.landlordMaintenanceRequestForProperty = {};
    },
  }
})
