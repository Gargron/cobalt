import { VIDEO_FETCH_SUCCESS } from '../actions';

const initialState = {};

export default function videoReducer(state = initialState, action) {
  switch (action.type) {
  case VIDEO_FETCH_SUCCESS:
    return { ...action.payload };
  default:
    return state;
  }
};
