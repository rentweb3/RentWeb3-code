import { Box, HStack, Text } from "@chakra-ui/react";
import React from "react";

function Footer() {
  return (
    <HStack color={"white"} bg={"black"} width={"100vw"} justify={"center"}>
      <Text fontSize={"16px"}>&#169; 2022 Rentweb3</Text>
    </HStack>
  );
}

export default Footer;
