import ShowMap from './Pages/ShowMap.vue'
import ShowCity from './Pages/ShowCity.vue'

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
        }
    ]