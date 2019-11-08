package main;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Main {

    private static int fileNumber = 1;

    public static void genGrid(String grid) throws IOException {
        String[] tokens = grid.split(";");

        String[] dimensions = tokens[0].split(",");
        String[] ironManLocation = tokens[1].split(",");
        String[] thanosLocation = tokens[2].split(",");
        String[] stonesLocations = tokens[3].split(",");

        String[][] visualisation = new String[Integer.parseInt(dimensions[0])][Integer.parseInt(dimensions[1])];

        String logicalSentences = "";
        logicalSentences += "dimensions("
                + dimensions[0] + ", "
                + dimensions[1] + ").\n\n";


        logicalSentences += "thanos_location("
                + thanosLocation[0] + ", "
                + thanosLocation[1] + ").\n\n";
        visualisation[Integer.parseInt(thanosLocation[0])][Integer.parseInt(thanosLocation[1])] = "T";

        String ironManStones = "";
        for (int i = 0; i < 4; i++) {
            logicalSentences += "stone("
                    + stonesLocations[2 * i] + ", "
                    + stonesLocations[2 * i + 1] + ").\n";
            visualisation[Integer.parseInt(stonesLocations[2 * i])][Integer.parseInt(stonesLocations[2 * i + 1])] = "S";

            ironManStones += "stone("
                    + stonesLocations[2 * i] + ", "
                    + stonesLocations[2 * i + 1] + ")";

            if (i != 3) {
                ironManStones += ", ";
            }
        }

        logicalSentences += "\niron_man_location("
                + ironManLocation[0] + ", "
                + ironManLocation[1] + ", "
                + "[" + ironManStones + "], "
                + "s0).";
        visualisation[Integer.parseInt(ironManLocation[0])][Integer.parseInt(ironManLocation[1])] = "I";

        printGrid(visualisation);

        BufferedWriter writer = new BufferedWriter(new FileWriter("../KB" + fileNumber++ + ".pl"));
        writer.write(logicalSentences);
        writer.close();

    }

    private static void printGrid(String[][] visualisation) {
        System.out.println("Knowledge Base " + fileNumber);
        for (String[] row : visualisation) {
            for (String cell : row) {
                if (cell == null) {
                    System.out.print("-");
                } else {
                    System.out.print(cell);
                }
                System.out.print("\t");
            }
            System.out.println("\n");
        }
    }

    public static void main(String[] args) throws IOException {
        genGrid("5,5;" +
                "1,2;" +
                "3,4;" +
                    "1,1," +
                    "2,1," +
                    "2,2," +
                    "3,3");
        genGrid("4,5;" +
                "1,2;" +
                "3,0;" +
                    "1,1," +
                    "2,1," +
                    "2,2," +
                    "2,3");
    }
}
