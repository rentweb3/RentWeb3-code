import { Box } from "@chakra-ui/react";
import React from "react";
import Footer from "../Footer/Footer";
import Introduction from "../Introduction/Introduction";
import Mission from "../Mission/Mission";
import PoweredBy from "../PoweredBy/PoweredBy";
import Services from "../Services/Services";
import Uniqueness from "../Uniqueness/Uniqueness";
function Home() {
  return (
    <Box width={"100%"}>
      <Introduction />
      <Mission />
      <Services />
      <Uniqueness />

      <PoweredBy />

      <Footer />
    </Box>
  );
}

export default Home;
