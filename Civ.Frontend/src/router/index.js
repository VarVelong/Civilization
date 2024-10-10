import { createRouter, createWebHistory } from 'vue-router'
import MapRoutes from '../components/modules/Map/MapRoutes'
import MenuRouter from '../components/modules/Menu/MenuRouter'

const routes = [].concat(MapRoutes, MenuRouter);

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: routes
});

export default router;


