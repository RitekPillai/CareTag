import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { HashRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/hooks/useAuth";
import { ThemeProvider } from "@/hooks/useTheme";
import { SessionProvider } from "@/context/SessionContext";
import { AppLayout } from "@/components/layout/AppLayout";
import Auth from "./pages/Auth";
import ResetPassword from "./pages/ResetPassword";
import Dashboard from "./pages/Dashboard";
import Patients from "./pages/Patients";
import PatientDetail from "./pages/PatientDetail";
import Appointments from "./pages/Appointments";
import Emergency from "./pages/Emergency";
import Records from "./pages/Records";
import Prescriptions from "./pages/Prescriptions";
import Reports from "./pages/Reports";
import Devices from "./pages/Devices";
import Settings from "./pages/Settings";
import Analytics from "./pages/Analytics";
import ScanCareTag from "./pages/ScanCareTag";
import ActiveSession from "./pages/ActiveSession";
import SessionEnd from "./pages/SessionEnd";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();
import ProtectedRoute from "./components/ProtectedRoute";

const App = () => (
  <QueryClientProvider client={queryClient}>
    <ThemeProvider>
      <AuthProvider>
        <SessionProvider>
          <TooltipProvider>
            <Toaster />
            <Sonner />
            <HashRouter>
              <Routes>
                {/* PUBLIC ROUTES */}
                <Route path="/auth" element={<Auth />} />
                <Route path="/reset-password" element={<ResetPassword />} />

                {/* PROTECTED ROUTES (Requires Login) */}
                <Route element={<ProtectedRoute />}>
                  <Route
                    path="/"
                    element={<AppLayout><Dashboard /></AppLayout>}
                  />
                  <Route
                    path="/patients"
                    element={<AppLayout><Patients /></AppLayout>}
                  />
                  <Route
                    path="/patients/:id"
                    element={<AppLayout><PatientDetail /></AppLayout>}
                  />
                  <Route
                    path="/appointments"
                    element={<AppLayout><Appointments /></AppLayout>}
                  />
                  <Route
                    path="/emergency"
                    element={<AppLayout><Emergency /></AppLayout>}
                  />
                  <Route
                    path="/records"
                    element={<AppLayout><Records /></AppLayout>}
                  />
                  <Route
                    path="/prescriptions"
                    element={<AppLayout><Prescriptions /></AppLayout>}
                  />
                  <Route
                    path="/reports"
                    element={<AppLayout><Reports /></AppLayout>}
                  />
                  <Route
                    path="/devices"
                    element={<AppLayout><Devices /></AppLayout>}
                  />
                  <Route
                    path="/settings"
                    element={<AppLayout><Settings /></AppLayout>}
                  />
                  <Route
                    path="/analytics"
                    element={<AppLayout><Analytics /></AppLayout>}
                  />
                  <Route
                    path="/session"
                    element={<AppLayout><ActiveSession /></AppLayout>}
                  />
                  <Route
                    path="/session/end"
                    element={<AppLayout><SessionEnd /></AppLayout>}
                  />
                </Route>

                {/* OTHER ROUTES */}
                <Route path="/scan" element={<ScanCareTag />} />
                <Route path="*" element={<NotFound />} />
              </Routes>
            </HashRouter>
          </TooltipProvider>
        </SessionProvider>
      </AuthProvider>
    </ThemeProvider>
  </QueryClientProvider>
);

export default App;
