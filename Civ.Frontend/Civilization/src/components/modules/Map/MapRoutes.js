import ShowMap from './Pages/ShowMap.vue'
import ShowCity from './Pages/ShowCity.vue'
import ShowArena from './Pages/ShowArena.vue'

export default
    [
        {
            path: '/game/:id?',
            name: 'game',
            component: ShowMap
        },

        {
            path: '/city/:id?',
            name: 'city',
            component: ShowCity
        },

        {
            path: '/arena',
            name: 'arena',
            component: ShowArena
        }
    ]