import { UPLOADS_FETCH_SUCCESS } from '../actions';

const initialState = [];

export default function uploadsReducer(state = initialState, action) {
  switch (action.type) {
  case UPLOADS_FETCH_SUCCESS:
    return action.payload;
  default:
    return state;
  }
};
