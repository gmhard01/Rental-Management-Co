import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import AvailableProperties from '../views/AvailableProperties.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import RentalProperty from '../views/RentalProperty.vue'
import Splash from '../views/Splash.vue'
import MyApartment from '../views/MyRental.vue'
import Landlord from '../views/Landlord.vue'
import Maintenance from '../views/Maintenance.vue'

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/available-properties/:page',
      name: 'available-properties',
      component: AvailableProperties,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/rental-property/:propertyId",
      name: "rental-property",
      component: RentalProperty,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/splash",
      name: "splash",
      component: Splash,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/my-rental',
      name: 'my-rental',
      component: MyApartment,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/my-rentals',
      name: 'my-rentals',
      component: Landlord,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/maintenance',
      name: 'maintenance',
      component: Maintenance,
      meta: {
        requiresAuth: false
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
