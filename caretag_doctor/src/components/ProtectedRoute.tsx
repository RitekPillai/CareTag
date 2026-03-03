import { Navigate, Outlet, useLocation } from 'react-router-dom';

const ProtectedRoute = () => {
  const token = localStorage.getItem('token');
  const location = useLocation();

  // DEBUG LOGS
  console.log("--- ProtectedRoute Guard ---");
  console.log("Current Path:", location.pathname);
  console.log("Token in Storage:", token ? "FOUND (starts with " + token.substring(0,10) + "...)" : "NOT FOUND");

  if (!token) {
    console.log("Redirecting to /auth because token is missing.");
    return <Navigate to="/auth" replace />;
  }

  console.log("Token valid! Rendering Dashboard content.");
  return <Outlet />;
  
};



export default ProtectedRoute;