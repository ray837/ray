import { useState, useEffect } from 'react';
import { Routes, Route } from "react-router-dom";
import Topbar from "./scenes/global/Topbar";
import Sidebar from "./scenes/global/Sidebar";
import Dashboard from "./scenes/dashboard";
import Team from "./scenes/team";
import Invoices from "./scenes/invoices";
import Contacts from "./scenes/contacts";
import Bar from "./scenes/bar";
import Form from "./scenes/form";
 
import Geography from "./scenes/geography";
import { CssBaseline, ThemeProvider } from "@mui/material";
import { ColorModeContext, useMode } from "./theme";
 
import { ethers } from "ethers";
 
import Doc from "./artifacts/contracts/Doc.sol/Doc.json";
 
import {
  BrowserRouter as Router,

 
} from "react-router-dom";

function App() {
  const [theme, colorMode] = useMode();
  const [isSidebar, setIsSidebar] = useState(true);
  const [state, setState] = useState({
    provider: null,
    signer: null,
    contract: null,
  });
   
  const [account, setAccount] = useState("None");
  useEffect(() => {
    const connectWallet = async () => {

      try {
        const { ethereum } = window;

        if (ethereum) {
          const account = await ethereum.request({
            method: "eth_requestAccounts",
          });



          window.ethereum.on("chainChanged", () => {
            window.location.reload();
          });

          window.ethereum.on("accountsChanged", () => {
            window.location.reload();
          });

          const provider = new ethers.providers.Web3Provider(ethereum);
          const signer = provider.getSigner();
          const contract = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
          setAccount(account);
          const con = new ethers.Contract(contract, Doc.abi, signer)
          setState({ provider, signer, con });

        } else {
          if (window.confirm("MetaMask Not Installed, Do you want to Install?"))
            window.location.href = "https://metamask.io/download/";
        }

      } catch (error) {
        console.log(error);
      }
    };
    connectWallet();
  }, []);

  return (
    <ColorModeContext.Provider value={colorMode}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <div className="app">
          <Sidebar isSidebar={isSidebar} />
          <main className="content">
            <Topbar setIsSidebar={setIsSidebar} />
            <Routes>
              <Route path="/" element={<Dashboard />} />
              <Route path="/attest" element={<Team />} />
              <Route path="/recieve" element={<Contacts />} />
              <Route path="/alogin" element={<Invoices />} />
              <Route path="/form" element={<Form />} />
              <Route path="/bar" element={<Bar />} />
               
              
              <Route path="/geography" element={<Geography />} />
            </Routes>
          </main>
        </div>
      </ThemeProvider>
    </ColorModeContext.Provider>
  );
}

export default App;
